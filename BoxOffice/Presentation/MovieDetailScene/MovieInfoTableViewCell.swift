//
//  MovieInfoTableViewCell.swift
//  BoxOffice
//
//  Created by EUNJU on 3/12/24.
//

import UIKit

final class MovieInfoTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        selectionStyle = .none
    }
    
    private func setUpLayout() {
        contentView.addSubview(movieInfoStackView)
        [titleLabel, infoLabel, movieInfoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        infoLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            movieInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func setUpData(with info: (title: String, info: String)?) {
         guard let info = info else { return }
         titleLabel.text = info.title
         infoLabel.text = info.info
     }
}
