//
//  ParentListVC.swift
//  Twitter
//
//  Created by Hiren Faldu on 17/07/22.
//

import UIKit

// MARK: - ListVC
class ParentLoadableListVC: ParentVC {
    
    // UI components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    let nextLoadingView = TableNextPageLoad(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: Geometry.screenWidth,
                                                          height: 60))
    let refresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self,
                          action: #selector(refreshData),
                          for: .valueChanged)
        return refresh
    }()
    
    
    // Properties
    let viewModel: LoadableListVM
    var nextPageLoadingText = "Loading next page"
    
    // Life cycle
    init(viewModel: LoadableListVM) {
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
        tableView.addSubview(refresh)
        nextLoadingView.updateText(text: nextPageLoadingText)
        tableView.tableFooterView = nextLoadingView
        nextLoadingView.isHidden = true
    }
}

// MARK: - Selector(s)
extension ParentLoadableListVC {
    
    @objc private func refreshData() {
        viewModel.reloadDate()
    }
}

// MARK: - Helper method(s)
extension ParentLoadableListVC {
    
    private final func setupLoadBinding() {
        viewModel.loadStatus.bind {[weak self] observable, status in
            guard let strongSelf = self else { return }
            switch status {
            case .idle:
                strongSelf.hideLoadingComponents()
            case .loading:
                strongSelf.refresh.endRefreshing()
                strongSelf.showLoader()
            case .nextPageLoading:
                strongSelf.hideLoadingComponents()
                strongSelf.showNextPageLodingView()
                break
            case .reloading:
                break
            case .error:
                strongSelf.hideLoadingComponents()
                strongSelf.tableView.reloadData()
            case .empty:
                strongSelf.hideLoadingComponents()
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    private func hideLoadingComponents() {
        refresh.endRefreshing()
        hideLoader()
        hideNextPageLoadingView()
    }
    
    private func hideNextPageLoadingView() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut) {[weak self] in
            self?.nextLoadingView.isHidden = true
            self?.nextLoadingView.activity.stopAnimating()
            self?.tableView.layoutIfNeeded()
        } completion: { _ in }
    }
    
    private func showNextPageLodingView() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut) {[weak self] in
            self?.nextLoadingView.activity.startAnimating()
            self?.nextLoadingView.isHidden = false
            self?.tableView.layoutIfNeeded()
        } completion: { _ in }
    }
}

// MARK: - Table veiw method(s)
extension ParentLoadableListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Check next page
        if  !viewModel.isAllLoaded,
            viewModel.loadStatus.value != .nextPageLoading,
            indexPath.row == viewModel.numberOfRowInSection(indexPath.section) - 1 {
            viewModel.loadNextPage()
        }
        // Deque cell
        let identifier = viewModel.cellIdentifierAt(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath)
        configureCell(cell, indexPath: indexPath)
        return cell
    }
}
