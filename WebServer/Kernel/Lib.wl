BeginPackage["ChristopherWolfram`WebServer`Lib`"];


$LibUWebSockets := $LibUWebSockets = (
  If[$System === "Windows-x86-64", LoadLibrary["uv"]]; FindLibrary["libuwebsockets"]
);


EndPackage[];
