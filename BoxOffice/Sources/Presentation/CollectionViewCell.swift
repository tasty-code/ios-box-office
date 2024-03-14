//
//  CollectionViewCell.swift
//  BoxOffice
//
//  Created by Roh on 3/11/24.
//

import UIKit

class CollectionViewCell: UICollectionViewListCell {
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "movieName"
        
        return label
    }()
    
    let movieRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "1"
        return label
    }()
    
    let changeRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 10)
        label.text = "changeRank"
        return label
    }()
    
    let movieNumberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 10)
        label.text = "numbers"
        return label
    }()
    
    lazy var rankAndChangeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [movieRankLabel, changeRankLabel])
        sv.axis = .vertical
        sv.spacing = 1
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var nameAndNumberOfPeopleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [movieNameLabel, movieNumberOfPeopleLabel])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addSubview(rankAndChangeStackView)
        addSubview(nameAndNumberOfPeopleStackView)
    }
    
    func setLayout() {
        rankAndChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndNumberOfPeopleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankAndChangeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rankAndChangeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            rankAndChangeStackView.widthAnchor.constraint(equalToConstant: frame.width / 5),
            rankAndChangeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            nameAndNumberOfPeopleStackView.topAnchor.constraint(equalTo: rankAndChangeStackView.topAnchor, constant:  5),
            nameAndNumberOfPeopleStackView.leadingAnchor.constraint(equalTo: rankAndChangeStackView.trailingAnchor, constant: 20),
            nameAndNumberOfPeopleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nameAndNumberOfPeopleStackView.bottomAnchor.constraint(equalTo: rankAndChangeStackView.bottomAnchor, constant: -5)
        ])
    }
}
