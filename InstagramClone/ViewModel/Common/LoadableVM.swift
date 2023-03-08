//
//  LoadableVM.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 18/07/22.
//

import Foundation

// MARK: - Load Status
enum LoadStatus {
    case idle
    case loading
    case nextPageLoading
    case reloading
    case error
    case empty
}

enum WebServiceOperationStatus {
    case idle
    case loading
    case finishedWithError(message: String)
}

// MARK: - Loadable VM
protocol LoadableVM {
    
    var loadStatus: Observable<LoadStatus> { get set }
    var isAllLoaded: Bool { get set }
    
    func loadData()
    func loadNextPage()
    func reloadDate()
}

typealias LoadableListVM = ListVM & LoadableVM
