BeginPackage["ChristopherWolfram`WebServer`Request`"];

ReadHTTPRequest

Begin["`Private`"];

Needs["ChristopherWolfram`WebServer`Lib`"]


(* requestGetFullURL *)

requestGetFullURLC := requestGetFullURLC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_req_get_full_url", {"OpaqueRawPointer", "RawPointer"::["RawPointer"::["UnsignedInteger8"]]} -> "CSizeT"
]

requestGetFullURL[request_] :=
	Module[{dest, size},
		dest = RawMemoryAllocate["RawPointer"::["UnsignedInteger8"]];
		size = requestGetFullURLC[request, dest];
		RawMemoryImport[RawMemoryRead[dest], {"String", size}]
	]


(* requestMethod *)

requestMethodC := requestMethodC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_req_get_case_sensitive_method", {"OpaqueRawPointer", "RawPointer"::["RawPointer"::["UnsignedInteger8"]]} -> "CSizeT"
]

requestMethod[request_] :=
	Module[{dest, size},
		dest = RawMemoryAllocate["RawPointer"::["UnsignedInteger8"]];
		size = requestMethodC[request, dest];
		RawMemoryImport[RawMemoryRead[dest], {"String", size}]
	]


(* requestHeaders *)

requestHeadersC := requestHeadersC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_req_for_each_header", {"OpaqueRawPointer", "OpaqueRawPointer", "OpaqueRawPointer"} -> "Void"
]

requestHeaders[request_] :=
	Module[{headers, callback},

		headers = {};

		(* TODO: Consider reusing the callback. *)
		callback = CreateForeignCallback[
			{headerName, headerNameSize, headerValue, headerValueSize, userData} |->
				AppendTo[headers,
					RawMemoryImport[headerName, {"String", headerNameSize}] -> RawMemoryImport[headerValue, {"String", headerValueSize}]
				],
			{
				"RawPointer"::["UnsignedInteger8"],
				"CSizeT",
				"RawPointer"::["UnsignedInteger8"],
				"CSizeT",
				"OpaqueRawPointer"
			} -> "Void"
		];

		requestHeadersC[request, callback, OpaqueRawPointer[0]];

		headers
	]



ReadHTTPRequest[request_] :=
	HTTPRequest[
		requestGetFullURL[request],
		<|
			"Method" -> requestMethod[request],
			"Headers" -> requestHeaders[request]
		|>
	]


End[];
EndPackage[];
