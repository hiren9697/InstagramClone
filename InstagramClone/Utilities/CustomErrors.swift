//
//  CustomErrors.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 22/05/22.
//

import Foundation

// MARK: - Custom Error
enum CustomError: Error {
    case JSONSerializationError
    case JSONDeserializationError
}

extension CustomError {
    public var isFatal: Bool {
        return false
    }
}

// MARK: - Custon String Convertible
extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .JSONSerializationError:
            return "Couldn't serialize swift object to Data"
        case .JSONDeserializationError:
            return "Couldn't deserialize Data to swift object"
        }
    }
    
}

// MARK: - Localized Error
extension CustomError: LocalizedError {
    public var errorDescription: String {
        switch self {
        case .JSONSerializationError:
            return "Couldn't serialize swift object to Data"
        case .JSONDeserializationError:
            return "Couldn't deserialize Data to swift object"
        }
    }
}
