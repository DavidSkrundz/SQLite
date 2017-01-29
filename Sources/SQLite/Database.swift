//
//  Database.swift
//  SQLite
//

public struct Database {
	public let fileName: String
	
	public func connect() throws -> Connection {
		return try Connection(fileName: self.fileName)
	}
}
