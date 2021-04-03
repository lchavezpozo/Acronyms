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

    private lazy var acronymListView: AcronymListView = {
        let view = AcronymListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
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

extension AcronymSearchViewController: AcronymListViewDelegate {
    func acronymListViewNumberOfRowsInSection() -> Int {
        return viewModel.totalAcronyms
    }

    func acronymListView(cellViewModelFor row: Int) -> AcronymCellViewModel? {
        let cellViewModel = viewModel.getCellViewModelFor(row: row)
        return cellViewModel
    }

}

private extension AcronymSearchViewController {

    func setupBinnings() {
        setupBiningReloadData()
        setupBiningStartLoading()
        setupBiningStopLoading()
        setupBinningRequestFailure()
        setupBinningEmptyView()
    }

    func setupBiningReloadData() {
        viewModel.didReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.acronymListView.removeEmptyView()
                self?.acronymListView.reloadList()
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

    // TODO - Pending handle RequestFailure
    func setupBinningRequestFailure() {
        
    }

    func setupBinningEmptyView() {
        viewModel.didShowEmptyData = { [weak self] in
            DispatchQueue.main.async {
                let query = "\"\(self?.searchBarView.searchBarText ?? "")\""
                let subtitle = "acronymSearchView.emptyResultSubtitle".localizedFormat(query)
                self?.acronymListView.emptyView.subtitle = subtitle
                self?.acronymListView.showEmptyView()
            }
        }
    }

}

private extension AcronymSearchViewController {

    func setupUI() {
        setupStyle()
        setupSearchBarView()
        setupTableView()
    }

    func setupStyle() {
        view.backgroundColor = .systemBackground
        title = "acronymSearchView.title".localized
    }

    func setupSearchBarView() {
        view.addSubview(searchBarView)
        searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupTableView() {
        view.addSubview(acronymListView)
        acronymListView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        acronymListView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        acronymListView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        acronymListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

