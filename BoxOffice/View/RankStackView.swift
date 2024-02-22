//
//  RankStackView.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import UIKit

final class RankStackView: UIStackView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let newMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "신작"
        return label
    }()
    
    private let rankStateView = RankStateView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(rank: String, rankState: String, rankChanged: String) {
        rankLabel.text = rank
        rankState == "NEW" ? configureNewMovieLabel() : configureRankChangedMovieLabel(rankChanged: rankChanged)
    }
}

private extension RankStackView {
    func setupStackView() {
        self.axis = .vertical
        self.spacing = 4
        self.distribution = .fill
        self.alignment = .center
    }
    
    func configureNewMovieLabel() {
        self.addArrangedSubview(rankLabel)
        self.addArrangedSubview(newMovieLabel)
    }
    
    func configureRankChangedMovieLabel(rankChanged: String) {
        rankStateView.configureRankStateView(rankState: rankChanged)
        self.addArrangedSubview(rankLabel)
        self.addArrangedSubview(rankStateView)
    }
}
