//
//  ParentListVC.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 18/07/22.
//

import UIKit

// MARK: - ListVC
class ParentListVC: ParentVC {
    
    // UI components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    // Properties
    let viewModel: ListVM
    
    // Life cycle
    init(viewModel: ListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLoadBinding()
    }
    
    // Methods can be overridden by child
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath) { }
    
    public func configureUI() {
        // TableView
        view.addSubview(tableView)
        tableView.addAnchors(
            top: YAnchor(anchor: view.topAnchor, constant: 0),
            bottom: YAnchor(anchor: view.bottomAnchor, constant: 0),
            leading: XAnchor(anchor: view.leadingAnchor, constant: 0),
            trailing: XAnchor(anchor: view.trailingAnchor, constant: 0)
        )
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.registerCellsAndHeaderFooter(tableView: tableView)
    }
}

// MARK: - Selector(s)
extension ParentListVC {
    
}

// MARK: - Helper method(s)
extension ParentListVC {
    
    private final func setupLoadBinding() {
        
    }
    
    private func hideLoadingComponents() {
        hideLoader()
    }
}

// MARK: - Table veiw method(s)
extension ParentListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = viewModel.cellIdentifierAt(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath)
        configureCell(cell, indexPath: indexPath)
        return cell
    }
}
