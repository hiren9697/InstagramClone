//
//  SearchVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 18/02/23.
//

import UIKit

// MARK: - VC
class SearchVC: ParentVC {
    
    let tableView = UITableView()
    let searchController = UISearchController()
    
    let vm = SearchVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBinders()
        vm.fetchUsers()
    }
}

// MARK: - UI method(s)
extension SearchVC {
    
    private func configureUI() {
        setupTableView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.title = "Search"
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        // Auto layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addAnchors(top: YAnchor(anchor: view.topAnchor, constant: 0),
                             bottom: YAnchor(anchor: view.bottomAnchor, constant: 0),
                             leading: XAnchor(anchor: view.leadingAnchor, constant: 0),
                             trailing: XAnchor(anchor: view.trailingAnchor, constant: 0))
        // Register cells
        tableView.register(SearchPeopleTC.self, forCellReuseIdentifier: SearchPeopleTC.identifier)
        // Mange Height
        tableView.estimatedRowHeight = 100//UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Helper method(s)
extension SearchVC {
    
    private func setupBinders() {
        vm.errorMessage.bind {[weak self] observable, message in
            guard let message = message,
            let _ = self else {
                return
            }
            Toast.shared.show(message)
        }
        vm.webServiceOperationStatus.bind {[weak self] observable, status in
            guard let strongSelf = self else { return }
            switch status {
            case .idle:
                strongSelf.hideLoader()
            case .loading:
                strongSelf.showLoader(disableInteraction: true)
            case .finishedWithError(let message):
                Toast.shared.show(message)
            }
        }
        vm.users.bind {[weak self] observable, users in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Search Result Updating
extension SearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        Log.info(searchController.searchBar.text!)
    }
}

// MARK: - TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchPeopleTC.identifier) as! SearchPeopleTC
        cell.updateUI(vm: vm.getUserVM(for: indexPath))
        return cell
    }
}
