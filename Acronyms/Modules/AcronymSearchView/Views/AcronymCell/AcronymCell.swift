//
//  AcronymCell.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import UIKit

class AcronymCell: UITableViewCell, CellProtocol {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 
        return label
    }()

    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()

    private let frequencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sinceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureCell(with viewModel: AcronymCellViewModel?) {
        nameLabel.text = viewModel?.name
        frequencyLabel.text = viewModel?.frequency
        sinceLabel.text = viewModel?.since
    }

}

private extension AcronymCell {

    func setupUI() {
        setupContainerView()
        setupNameLabel()
        setupStackViewContainer()
        setupFrequencyLabel()
        setupSinceLabel()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }

    func setupStackViewContainer() {
        containerView.addSubview(stackViewContainer)
        stackViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }

    func setupFrequencyLabel() {
        stackViewContainer.addArrangedSubview(frequencyLabel)
    }

    func setupSinceLabel() {
        stackViewContainer.addArrangedSubview(sinceLabel)
    }

}
