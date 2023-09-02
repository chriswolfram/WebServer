BeginPackage["ChristopherWolfram`WebServer`Lib`"];


$LibUWebSockets := $LibUWebSockets = (
  If[$SystemID === "Windows-x86-64", LibraryLoad["uv"]]; FindLibrary["libuwebsockets"]
);


EndPackage[];
