//
//  Database.swift
//  SQLite
//

public struct Database {
	public let fileName: String
	
	public init(fileName: String) {
		self.fileName = fileName
	}
	
	public func connect() throws -> Connection {
		return try Connection(fileName: self.fileName)
	}
}
