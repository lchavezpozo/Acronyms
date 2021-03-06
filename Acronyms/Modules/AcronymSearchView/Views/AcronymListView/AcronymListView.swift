//
//  AcronymListView.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit

protocol AcronymListViewDelegate: class {
    func acronymListViewNumberOfRowsInSection() -> Int
    func acronymListView(cellViewModelFor row: Int) -> AcronymCellViewModel?
}

class AcronymListView: UIView, EmptyViewProtocol {
    
    weak var delegate: AcronymListViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(AcronymCell.self, forCellReuseIdentifier: AcronymCell.identifier)
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.allowsSelection = false
        return tv
    }()
    
    lazy var emptyView: SearchEmptyView = {
        let view = SearchEmptyView(title: "acronymSearchView.emptyResultTitle".localized)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadList() {
        tableView.reloadData()
        tableView.contentOffset = .zero
    }
    
}

extension AcronymListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.acronymListViewNumberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  AcronymCell.identifier) as? AcronymCell,
              let cellViewModel =  delegate?.acronymListView(cellViewModelFor: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(with: cellViewModel)
        return cell
    }

}

private extension AcronymListView {
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
