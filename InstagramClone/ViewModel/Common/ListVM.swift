//
//  ListVM.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 05/07/22.
//

import UIKit

// MARK: - List VM
protocol ListVM {
    func numberOfSection()-> Int
    func numberOfRowInSection(_ section: Int)-> Int
    func cellIdentifierAt(_ indexPath: IndexPath)-> String
    func cellViewModelAt(_ indexPath: IndexPath)-> Any?
    func registerCellsAndHeaderFooter(tableView: UITableView)
    func headerIdentifierAt(_ section: Int)-> String?
    func headerViewModelAt(_ section: Int)-> Any?
    func footerIdentifierAt(_ section: Int)-> String?
    func footerViewModelAt(_ section: Int)-> Any?
}

// MARK: - HeaderFooter
extension ListVM {
    func headerIdentifierAt(_ section: Int)-> String? {
        nil
    }
    func headerViewModelAt(_ section: Int)-> Any? {
        nil
    }
    func footerIdentifierAt(_ section: Int)-> String? {
        nil
    }
    func footerViewModelAt(_ section: Int)-> Any? {
        nil
    }
}

















































