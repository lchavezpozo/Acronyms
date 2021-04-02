//
//  IndicatorTitleView.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import UIKit

class IndicatorTitleView: UIView {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var isAnimating: Bool {
        return indicatorView.isAnimating
    }

    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(title: String?) {
        self.title = title
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        indicatorView.startAnimating()
    }

    func stopAnimation() {
        indicatorView.stopAnimating()
    }

}

private extension IndicatorTitleView {

    func setupUI() {
        setupIndicatorView()
        setupTitleLabel()
    }

    func setupIndicatorView() {
        addSubview(indicatorView)
        indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
