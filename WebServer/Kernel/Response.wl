BeginPackage["ChristopherWolfram`WebServer`Response`"];

WriteHTTPResponse

Begin["`Private`"];

Needs["ChristopherWolfram`WebServer`Lib`"]


(* responseWriteStatusC *)

responseWriteStatusC := responseWriteStatusC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_res_write_status", {"CInt", "OpaqueRawPointer", "RawPointer"::["UnsignedInteger8"], "CSizeT"} -> "Void"
]


(* responseWriteHeader *)
(* DLL_EXPORT void uws_res_write_header(int ssl, uws_res_t *res, const char *key, size_t key_length, const char *value, size_t value_length); *)
responseWriteHeaderC := responseWriteHeaderC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_res_write_header",
	{
		"CInt",
		"OpaqueRawPointer",
		"RawPointer"::["UnsignedInteger8"],
		"CSizeT",
		"RawPointer"::["UnsignedInteger8"],
		"CSizeT"
	} -> "Void"
]

responseWriteHeader[ssl_?BooleanQ, response_, headerName_, headerValue_] :=
	With[{headerNameString = ToString[headerName], headerValueString = ToString[headerValue]},
		responseWriteHeaderC[
			Boole[ssl],
			response,
			RawMemoryExport[headerNameString],
			StringLength[headerNameString],
			RawMemoryExport[headerValueString],
			StringLength[headerValueString]
		]
	]


(* responseWriteEndC *)

responseWriteEndC := responseWriteEndC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_res_end",
		{
			"CInt",
			"OpaqueRawPointer",
			"RawPointer"::["UnsignedInteger8"],
			"CSizeT",
			"CInt" (* bool *)
		} -> "Void"
];


WriteHTTPResponse[ssl_?BooleanQ, httpResponse_, response_] :=
	Module[{statusString, bodyBytes},

		statusString = ToString[httpResponse["StatusCode"]];
		responseWriteStatusC[Boole[ssl], response, RawMemoryExport[statusString], StringLength[statusString]];

		responseWriteHeader[ssl, response, #1, #2]&@@@httpResponse["Headers"];

		bodyBytes = httpResponse["BodyByteArray"];
		responseWriteEndC[Boole[ssl], response, RawMemoryExport[bodyBytes], Length[bodyBytes], 0]
	]



End[];
EndPackage[];
