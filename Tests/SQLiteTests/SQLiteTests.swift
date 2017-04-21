//
//  SQLiteTests.swift
//  SQLite
//

@testable import SQLite
import XCTest

func some(context: OpaquePointer?,
          argc: Int32,
          values: UnsafeMutablePointer<OpaquePointer?>?) -> Void {
	let value = SQLite.getDouble(values![0])	
	SQLite.returnDouble(context, value * 10)
}

class SQLiteTests: XCTestCase {
	func testExample() throws {
		let database = Database(fileName: "mydb.sql")
		let connection = try database.connect()
		
		connection.createFunction("some", argc: 1, function: some)
		
		let statement = "SELECT some(5);"
		
		let result = connection.unsafeExecute(statement)
		print(result ?? "")
	}
	
	static var allTests = [
		("testExample", testExample),
	]
}
