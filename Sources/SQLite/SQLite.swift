//
//  SQLite.swift
//  SQLite
//

import CSQLite

public struct SQLite {}

extension SQLite {
	public static func getDouble(_ value: OpaquePointer?) -> Double {
		return sqlite3_value_double(value)
	}
	
	public static func getInt(_ value: OpaquePointer?) -> Int {
		return Int(sqlite3_value_int(value))
	}
	
	public static func getText(_ value: OpaquePointer?) -> String {
		return String(cString: sqlite3_value_text(value))
	}
}

extension SQLite {
	public static func returnDouble(_ context: OpaquePointer?, _ value: Double) {
		sqlite3_result_double(context, value)
	}
	
	public static func returnInt(_ context: OpaquePointer?, _ value: Int32) {
		sqlite3_result_int(context, value)
	}
	
	public static func returnNil(_ context: OpaquePointer?) {
		sqlite3_result_null(context)
	}
	
	public static func returnText(_ context: OpaquePointer?, _ value: String) {
		sqlite3_result_text(context,
		                    value.withCString { $0 },
		                    Int32(value.utf8.count),
		                    nil)
	}
}
