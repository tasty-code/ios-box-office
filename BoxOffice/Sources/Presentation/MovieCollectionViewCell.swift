//
//  CollectionViewCell.swift
//  BoxOffice
//
//  Created by Roh on 3/11/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewListCell {
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.text = ""
        return label
    }()
    
    private let movieRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.text = ""
        return label
    }()
    
    private let movieChangeRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = ""
        return label
    }()
    
    private let movieNumberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = ""
        return label
    }()
    
    private lazy var rankAndChangeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieRankLabel, movieChangeRankLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var nameAndNumberOfPeopleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieNumberOfPeopleLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
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
            rankAndChangeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            rankAndChangeStackView.widthAnchor.constraint(equalToConstant: frame.width / 5),
            rankAndChangeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            nameAndNumberOfPeopleStackView.topAnchor.constraint(equalTo: rankAndChangeStackView.topAnchor, constant:  10),
            nameAndNumberOfPeopleStackView.leadingAnchor.constraint(equalTo: rankAndChangeStackView.trailingAnchor, constant: 20),
            nameAndNumberOfPeopleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nameAndNumberOfPeopleStackView.bottomAnchor.constraint(equalTo: rankAndChangeStackView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with result: BoxOfficeEntity) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let audienceCountInt = Int(result.audienceCount),
              let audiAccInt = Int(result.audiAcc),
              let audienceCount = numberFormatter.string(from: NSNumber(value: audienceCountInt)),
              let audiAcc =   numberFormatter.string(from: NSNumber(value: audiAccInt))
        else {
            return
        }
        
        movieNameLabel.text = result.movieName
        movieRankLabel.text = result.rank
        movieNumberOfPeopleLabel.text =  "오늘 \(audienceCount)/ 총\(audiAcc)"
        
        if result.isNewMovie {
            movieChangeRankLabel.text = "신작"
            movieChangeRankLabel.textColor = .red
            return
        }
        
        guard let rankChangeValueInt = Int(result.rankChangeValue) else {
            return
        }
        
        if rankChangeValueInt > 0 {
            movieChangeRankLabel.text = "▲\(rankChangeValueInt)"
            movieChangeRankLabel.textColor = .red
        }
        else if rankChangeValueInt < 0 {
            movieChangeRankLabel.text = "▼\(-rankChangeValueInt)"
            movieChangeRankLabel.textColor = .blue
        }
        else {
            movieChangeRankLabel.text = "-"
        }
    }
}
