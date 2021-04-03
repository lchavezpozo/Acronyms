//
//  SearchBar.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import UIKit


protocol SearchBarViewDelegate: class {
    func searchBarView(_ searchBarView: SearchBarView, textDidChange: String)
}

class SearchBarView: UIView {

    weak var delegate: SearchBarViewDelegate?

    private var viewModel: SearchBarViewModel

    var searchBarText: String? {
        return searchBar.text
    }

    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .systemBackground
        sb.placeholder = viewModel.placeholderText
        sb.delegate = self
        return sb
    }()

    private lazy var indicatorTitleView: IndicatorTitleView = {
        let indicator = IndicatorTitleView(title: viewModel.indicatorTitleText)
        indicator.alpha = 0
        return indicator
    }()

    init(with viewModel: SearchBarViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupBinning()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startSearching() {
        indicatorTitleView.startAnimating()
        animationShowIndicatorTitleView(isHidden: false)
    }

    func stopSearching() {
        indicatorTitleView.stopAnimation()
        animationShowIndicatorTitleView(isHidden: true)
    }

    private func animationShowIndicatorTitleView(isHidden: Bool) {
        indicatorTitleView.alpha = isHidden ? 0 : 1
    }
    
    private func handleTextDidChange(text: String) {
        delegate?.searchBarView(self, textDidChange: text)
    }

}

extension SearchBarView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handleTextDidChange(text: searchText)
    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return viewModel.validationChange(text: text)
    }

}

private extension SearchBarView {
    
    func setupBinning() {
        setupBinningTextDidChange()
    }
    
    func setupBinningTextDidChange() {
        viewModel.didChangeText = { [weak self] text in
            self?.handleTextDidChange(text: text)
        }
    }
}

private extension SearchBarView {

    func setupUI() {
        setupStyle()
        setupStackViewContainer()
        setupSearchBar()
        setupIndicatorView()
    }

    func setupStyle() {
        backgroundColor = .systemBackground
    }

    func setupStackViewContainer() {
        addSubview(stackViewContainer)
        stackViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setupSearchBar() {
        stackViewContainer.addArrangedSubview(searchBar)
    }

    func setupIndicatorView() {
        stackViewContainer.addArrangedSubview(indicatorTitleView)
        searchBar.sendSubviewToBack(indicatorTitleView)
    }

}
