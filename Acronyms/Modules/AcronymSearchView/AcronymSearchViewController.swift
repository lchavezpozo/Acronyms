//
//  ViewController.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import UIKit

class AcronymSearchViewController: UIViewController {

    private var viewModel: AcronymSearchViewModel

    private lazy var searchBarView: SearchBarView = {
        let view = SearchBarView(with: viewModel.searchBarViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(AcronymCell.self, forCellReuseIdentifier: AcronymCell.identifier)
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorStyle = .none
        tv.dataSource = self
        return tv
    }()

    init(with viewModel: AcronymSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinnings()
        setupUI()
    }

}

extension AcronymSearchViewController: SearchBarViewDelegate {

    func searchBarView(_ searchBarView: SearchBarView, textDidChange: String) {
        viewModel.search(text: textDidChange)
    }
    
}

extension AcronymSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalAcronyms
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  AcronymCell.identifier) as? AcronymCell
        let cellViewModel = viewModel.getCellViewModelFor(row: indexPath.row)
        cell?.configureCell(with: cellViewModel)
        return cell ?? UITableViewCell()
    }

}

private extension AcronymSearchViewController {

    func setupBinnings() {
        setupBiningReloadData()
        setupBiningStartLoading()
        setupBiningStopLoading()
        setupBinningRequestFailure()
    }
    
    func setupBiningReloadData() {
        viewModel.didReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupBiningStartLoading() {
        viewModel.didStartLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.searchBarView.startSearching()
            }
        }
    }
    
    func setupBiningStopLoading() {
        viewModel.didStopLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.searchBarView.stopSearching()
            }
        }
    }
    
    func setupBinningRequestFailure() {
        
    }

}

private extension AcronymSearchViewController {

    func setupUI() {
        setupStyle()
        setupSearchBarView()
        setupTableView()
    }

    func setupStyle() {
        view.backgroundColor = .white
    }

    func setupSearchBarView() {
        view.addSubview(searchBarView)
        searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

