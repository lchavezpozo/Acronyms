//
//  EmptyViewProtocol.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit


protocol EmptyViewProtocol {
    associatedtype T: UIView
    
    var emptyView: T { get }
    func showEmptyView()
    func removeEmptyView()
}

extension EmptyViewProtocol where Self: UIView {

    func showEmptyView() {
        removeEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyView)
        emptyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func removeEmptyView() {
        emptyView.removeFromSuperview()
    }

}


