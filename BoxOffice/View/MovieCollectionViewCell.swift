//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/02.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewListCell {

    static let identifier = "MovieCell"

    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    lazy var oldAndNewLabel: UILabel = {
        let label = UILabel()
        label.text = "진입"
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "왕의 남자"
        return label
    }()
    lazy var audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "총 백만명"
        return label
    }()

    lazy var lankStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, oldAndNewLabel])
        stackView.axis = .vertical
        return stackView
    }()

    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, audienceLabel])
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        accessories = [.disclosureIndicator()]
        contentView.addSubview(lankStackView)
        contentView.addSubview(nameStackView)

        lankStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lankStackView.topAnchor.constraint(equalTo: self.topAnchor),
            lankStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lankStackView.widthAnchor.constraint(equalToConstant: self.frame.width / 2),

            nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameStackView.topAnchor.constraint(equalTo: self.topAnchor),
            nameStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: lankStackView.trailingAnchor)
        ])
    }

}
