SQLite [![Swift Version](https://img.shields.io/badge/Swift-3.1-orange.svg)](https://swift.org/download/#releases) [![Platforms](https://img.shields.io/badge/Platforms-macOS%20|%20Linux-lightgray.svg)](https://swift.org/download/#releases) [![Build Status](https://travis-ci.org/DavidSkrundz/SQLite.svg?branch=master)](https://travis-ci.org/DavidSkrundz/SQLite) [![Codebeat Status](https://codebeat.co/badges/3f5af7d9-832f-4b7e-81bf-dfe921a930d4)](https://codebeat.co/projects/github-com-davidskrundz-sqlite) [![Codecov](https://codecov.io/gh/DavidSkrundz/SQLite/branch/master/graph/badge.svg)](https://codecov.io/gh/DavidSkrundz/SQLite)
======

A (currently limited) Swift wrapper for sqlite


Use
---
```Swift
func some(context: OpaquePointer?,
          argc: Int32,
          values: UnsafeMutablePointer<OpaquePointer?>?) -> Void {
	let value = SQLite.getDouble(values![0])
	print("Got \(value)")

	SQLite.returnDouble(context, value * 10)
}

let database = Database(fileName: "mydb.sql")
let connection = try database.connect()
connection.createFunction("some", argc: 1, function: some)

let statement = "SELECT some(5);"

let result = connection.unsafeExecute(statement)
print(result ?? "")
```


Supported Types
---------------
Currently all returned values are String, but Ints and Doubles can be gotten and returned from user-defined functions.
