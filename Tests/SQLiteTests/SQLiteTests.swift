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
	print("Got \(value)")
	
	SQLite.returnDouble(context, value * 10)
}

class SQLiteTests: XCTestCase {
	func testExample() throws {
		let database = Database(fileName: "mydb.sql")
		let connection = try database.connect()
		
		connection.createFunction("some", argc: 1, function: some)
		
		let statement =
			"SELECT some(5);"
//			"WITH RECURSIVE port(id) AS ( "
//		+	"  SELECT a.id "
//		+	"  FROM airports a "
//		+	"  WHERE a.iata = 'YEG' "
//		+	"    UNION "
//		+	"  SELECT a.id "
//		+	"  FROM airports a "
//		+	"  INNER JOIN routes r "
//		+	"    ON r.destinationairportid = a.id "
//		+	"  INNER JOIN port p "
//		+	"    ON p.id = r.sourceairportid "
//		+	") "
//		+	"SELECT a.* "
//		+	"FROM airports a "
//		+	"LEFT JOIN port p "
//		+	"  ON a.id = p.id "
//		+	"WHERE p.id IS NOT NULL AND a.altitude = ("
//		+	"WITH RECURSIVE port(id) AS ( "
//		+	"  SELECT a.id "
//		+	"  FROM airports a "
//		+	"  WHERE a.iata = 'YEG' "
//		+	"    UNION "
//		+	"  SELECT a.id "
//		+	"  FROM airports a "
//		+	"  INNER JOIN routes r "
//		+	"    ON r.destinationairportid = a.id "
//		+	"  INNER JOIN port p "
//		+	"    ON p.id = r.sourceairportid "
//		+	") "
//		+	"SELECT a.altitude "
//		+	"FROM airports a "
//		+	"LEFT JOIN port p "
//		+	"  ON a.id = p.id "
//		+	"ORDER BY a.altitude "
//		+	"DESC LIMIT 1 "
//		+	");"
		
		let result = connection.unsafeExecute(statement)
		print(result ?? "")
	}
	
	static var allTests = [
		("testExample", testExample),
	]
}
