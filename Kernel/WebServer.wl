BeginPackage["ChristopherWolfram`WebServer`"];

StartWebServer

Begin["`Private`"];

Needs["ChristopherWolfram`WebServer`Lib`"]
Needs["ChristopherWolfram`WebServer`App`"]
Needs["ChristopherWolfram`WebServer`Request`"]
Needs["ChristopherWolfram`WebServer`Response`"]


ssl = False;


appAnyC := appAnyC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_app_any",
		{
			"CInt",
			"OpaqueRawPointer",
			"RawPointer"::["UnsignedInteger8"],
			"OpaqueRawPointer",
			"OpaqueRawPointer"
		} -> "Void"
];

appListenC := appListenC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_app_listen",
		{
			"CInt",
			"OpaqueRawPointer",
			"CInt",
			"OpaqueRawPointer",
			"OpaqueRawPointer"
		} -> "Void"
];

appRunC := appRunC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_app_run", {"CInt", "OpaqueRawPointer"} -> "Void"
];


(*
	From From libuwebsockets.h:

	typedef struct {
		int port;
		const char *host;
		int options;
	} uws_app_listen_config_t;
*)

configType = {
	"CInt",
	"RawPointer"::["UnsignedInteger8"],
	"CInt"
};


StartWebServer[content_, port_] :=
	Module[{app, requestHandler, listenHandler},

		app = CreateApp[ssl];

		requestHandler = CreateForeignCallback[
			{response, request, userData} |->
				Module[{httpRequest, httpResponse},
					httpRequest = ReadHTTPRequest[request];
					httpResponse = GenerateHTTPResponse[content, httpRequest];
					WriteHTTPResponse[ssl, httpResponse, response]
				],
			{"OpaqueRawPointer", "OpaqueRawPointer", "OpaqueRawPointer"} -> "Void"
		];

		listenHandler = CreateForeignCallback[
			{socket, config, userData} |-> Null,
			{"OpaqueRawPointer", configType, "OpaqueRawPointer"} -> "Void"
		];

		appAnyC[Boole[ssl], app, RawMemoryExport["/*"], requestHandler, OpaqueRawPointer[0]];
		appListenC[Boole[ssl], app, port, listenHandler, OpaqueRawPointer[0]];
		appRunC[Boole[ssl], app];

	]


End[];
EndPackage[];
