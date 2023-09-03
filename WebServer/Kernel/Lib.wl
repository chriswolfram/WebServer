BeginPackage["ChristopherWolfram`WebServer`Lib`"];


(* This is a bit of a hacky way of dealing with library dependencies *)
$LibUWebSockets := $LibUWebSockets = (
  If[$SystemID === "Windows-x86-64", LibraryLoad["uv"]]; FindLibrary["libuwebsockets"]
);


EndPackage[];
