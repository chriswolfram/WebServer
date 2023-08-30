BeginPackage["ChristopherWolfram`WebServer`App`"];

CreateApp

Begin["`Private`"];

Needs["ChristopherWolfram`WebServer`Lib`"]


(*
	From From libusockets.h:

	struct us_socket_context_options_t {
		const char *key_file_name;
		const char *cert_file_name;
		const char *passphrase;
		const char *dh_params_file_name;
		const char *ca_file_name;
		const char *ssl_ciphers;
		int ssl_prefer_low_memory_usage; /* Todo: rename to prefer_low_memory_usage and apply for TCP as well */
	};
*)

optionsType = {
	"RawPointer"::["UnsignedInteger8"],
	"RawPointer"::["UnsignedInteger8"],
	"RawPointer"::["UnsignedInteger8"],
	"RawPointer"::["UnsignedInteger8"],
	"RawPointer"::["UnsignedInteger8"],
	"RawPointer"::["UnsignedInteger8"],
	"CInt"
};

createAppC := createAppC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_create_app", {"CInt", optionsType} -> "OpaqueRawPointer"
];

appDestroyC := appDestroyC = ForeignFunctionLoad[$LibUWebSockets,
	"uws_app_destroy", {"CInt", "OpaqueRawPointer"} -> "Void"
];


CreateApp[ssl_?BooleanQ] :=
	CreateManagedObject[
		createAppC[
			Boole[ssl],
			{
				RawPointer[0, "UnsignedInteger8"],
				RawPointer[0, "UnsignedInteger8"],
				RawPointer[0, "UnsignedInteger8"],
				RawPointer[0, "UnsignedInteger8"],
				RawPointer[0, "UnsignedInteger8"],
				RawPointer[0, "UnsignedInteger8"],
				0
			}
		],
		appDestroyC[Boole[ssl], #]&
	]


End[];
EndPackage[];
