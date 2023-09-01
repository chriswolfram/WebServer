BeginPackage["ChristopherWolfram`WebServer`Lib`"];


$LibUWebSockets := $LibUWebSockets = (
  If[$SystemID === "Windows-x86-64", LoadLibrary["uv"]]; FindLibrary["libuwebsockets"]
);


EndPackage[];
