//
//  FeedVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 18/02/23.
//

import UIKit

// MARK: - VC
class FeedVC: ParentVC {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTC.self, forCellReuseIdentifier: FeedTC.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureUI()
    }
}

// MARK: - Helper mehtod(s)
extension FeedVC {
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.addAnchors(top: YAnchor(anchor: view.topAnchor, constant: 0),
                             bottom: YAnchor(anchor: view.bottomAnchor, constant: 0),
                             leading: XAnchor(anchor: view.leadingAnchor, constant: 0),
                             trailing: XAnchor(anchor: view.trailingAnchor, constant: 0))
    }
}

// MARK: - TableView method(s)
extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTC.identifier, for: indexPath) as! FeedTC
        //cell.configureUI()
        return cell
    }
}
