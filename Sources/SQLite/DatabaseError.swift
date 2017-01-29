//
//  DatabaseError.swift
//  SQLite
//

public enum DatabaseError: Error {
	case FailedToOpen(message: String)
	case FailedToPrepare(message: String)
}
