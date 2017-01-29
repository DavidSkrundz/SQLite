//
//  Package.swift
//  SQLite3
//

import PackageDescription

let package = Package(
	name: "SQLite",
	dependencies: [
		.Package(url: "https://github.com/DavidSkrundz/CSQLite.git", majorVersion: 3, minor: 14),
	]
)

let staticLibrary = Product(
	name: "SQLite",
	type: .Library(.Static),
	modules: ["SQLite"]
)
let dynamicLibrary = Product(
	name: "SQLite",
	type: .Library(.Dynamic),
	modules: ["SQLite"]
)

products.append(staticLibrary)
products.append(dynamicLibrary)
