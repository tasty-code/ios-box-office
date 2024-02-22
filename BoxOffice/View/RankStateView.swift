//
//  RankStateView.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import UIKit

final class RankStateView: UIStackView {
    private let rankStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()
    
    private let rankUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private let rankDownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureRankStateView(rankState: String) {
        guard let intRankState = Int(rankState) else { return }
        
        switch intRankState {
        case let state where 0 < state :
            return configureRankUp(rankState: rankState)
        case let state where state < 0 :
            return configureRankDown(rankState: rankState)
        default:
            return configureRankNone()
        }
    }
}

private extension RankStateView {
    func setupStackView() {
        self.axis = .horizontal
        self.spacing = 0
        self.distribution = .fill
        self.alignment = .center
    }
    
    func configureRankUp(rankState: String) {
        self.rankStateLabel.text = rankState
        self.addArrangedSubview(rankUpImage)
        self.addArrangedSubview(rankStateLabel)
    }
    
    func configureRankDown(rankState: String) {
        self.rankStateLabel.text = rankState
        self.addArrangedSubview(rankDownImage)
        self.addArrangedSubview(rankStateLabel)
    }
    
    func configureRankNone() {
        self.rankStateLabel.text = "-"
        self.addArrangedSubview(rankStateLabel)
    }
}
