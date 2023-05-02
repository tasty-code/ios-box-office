//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/02.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieCell"

    var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    var oldAndNewLabel: UILabel = {
        let label = UILabel()
        label.text = "진입"
        return label
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "왕의 남자"
        return label
    }()
    var audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "총 백만명"
        return label
    }()

    var lankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var nameStackView: UIStackView = {
        let stackView = UIStackView()
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
        contentView.addSubview(lankStackView)
        contentView.addSubview(nameStackView)

        lankStackView.addSubview(rankLabel)
        lankStackView.addSubview(oldAndNewLabel)
        nameStackView.addSubview(nameLabel)
        nameStackView.addSubview(audienceLabel)

        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        oldAndNewLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        lankStackView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            lankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lankStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),

            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: lankStackView.trailingAnchor)
        ])
    }

}
