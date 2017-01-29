//
//  Connection.swift
//  SQLite
//

import CSQLite

public final class Connection {
	private var database: OpaquePointer?
	
	public init(fileName: String) throws {
		guard sqlite3_open(fileName, &self.database) == 0 else {
			sqlite3_close(self.database)
			throw DatabaseError
				.FailedToOpen(message:
					"Err: \(String(cString: sqlite3_errmsg(self.database)))")
		}
	}
	
	deinit {
		sqlite3_close(self.database)
	}
	
	public func execute(_ query: StaticString) -> Result? {
		return self.unsafeExecute(query.description)
	}
	
	public func unsafeExecute(_ query: String) -> Result? {
		if query.isEmpty { return nil }
		
		var statement: OpaquePointer?
		var unsusedQueryOffset: UnsafePointer<Int8>?
		
		guard sqlite3_prepare_v2(self.database,
		                         query,
		                         -1,
		                         &statement,
		                         &unsusedQueryOffset) == 0 else {
			print("Err: \(String(cString: sqlite3_errmsg(self.database)))")
			return nil
		}
		defer { sqlite3_finalize(statement) }
		
		var result = Result()
		while sqlite3_step(statement) == 100 {
			var row = ResultRow()
			for column in 0..<sqlite3_column_count(statement) {
				if let cstring = sqlite3_column_text(statement, column) {
					row.append(String(cString: cstring))
				}
			}
			result.append(row)
		}
		
		return result
	}
	
	public func createFunction(_ name: String,
	                           argc: Int32,
	                           function: @escaping
	                                     @convention(c)
	                                     (OpaquePointer?,
	                                      Int32,
	                                      UnsafeMutablePointer<OpaquePointer?>?) -> Void) {
		sqlite3_create_function_v2(self.database,
		                           name,
		                           argc,
		                           1, // SQLITE_UTF8
		                           nil,
		                           function,
		                           nil,
		                           nil,
		                           nil)
	}
}
