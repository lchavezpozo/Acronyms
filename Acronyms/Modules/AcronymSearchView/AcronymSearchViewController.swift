//
//  ViewController.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import UIKit

class AcronymSearchViewController: UIViewController {

    private var searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

private extension AcronymSearchViewController {

    func setupUI() {
        setupStyle()
        setupSearchBarView()
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
}

