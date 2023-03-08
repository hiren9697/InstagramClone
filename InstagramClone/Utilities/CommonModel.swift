//
//  CommonModel.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 20/05/22.
//

import Foundation

// MARK: - Pagination
struct Pagination {
    public let initialPage: UInt = 0
    public var total: UInt
    public var currentPage: UInt
    public let perPage: UInt
    public var offset: UInt {
        return currentPage * perPage
    }
    public var nextPage: UInt {
        currentPage + 1
    }
    
    init(perPage: UInt) {
        total = 0
        currentPage = initialPage
        self.perPage = perPage
    }
    
    public mutating func incrementCurrentPage() {
        currentPage += 1
    }
    
    public mutating func reset() {
        currentPage = initialPage
    }
}

// MARK: - Loading
enum Loading {
    case idle
    case initial
    case refresh
    case more
}

struct AppError {
    let title: String
    let message: String
    
    init(title: String = "Error",
         message: String) {
        self.title = title
        self.message = message
    }
}

// MARK: - Type Alias
typealias VoidCallback = (()-> ())
typealias ErrorCallback = ((Error)-> ())
typealias StringCallback = ((String)-> ())
typealias IntCallback = ((Int)-> ())
typealias BoolCallback = ((Bool)-> ())
typealias ResultCallback = ((Result<Any, Error>)-> ())
typealias AppErrorCallback = ((AppError)-> ())

enum FirebaseError: Error {
    case emptyList
    case listLoadingError
}
