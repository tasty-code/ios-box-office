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
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()
    
    private let rankUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .systemRed
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    
    private let rankDownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = .systemBlue
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        rankUpImage.translatesAutoresizingMaskIntoConstraints = false
        rankUpImage.heightAnchor.constraint(equalTo: rankStateLabel.heightAnchor).isActive = true
    }
    
    func configureRankDown(rankState: String) {
        self.rankStateLabel.text = rankState
        self.addArrangedSubview(rankDownImage)
        self.addArrangedSubview(rankStateLabel)
        rankDownImage.translatesAutoresizingMaskIntoConstraints = false
        rankDownImage.heightAnchor.constraint(equalTo: rankStateLabel.heightAnchor).isActive = true
    }
    
    func configureRankNone() {
        self.rankStateLabel.text = "-"
        self.addArrangedSubview(rankStateLabel)
    }
}

extension RankStateView {
    func configureRankStateView(rankState: String) {
        guard 
            let intRankState = Int(rankState) 
        else {
            return
        }
        switch intRankState {
        case let state where 0 < state :
            return configureRankUp(rankState: rankState)
        case let state where state < 0 :
            return configureRankDown(rankState: String(abs(intRankState)))
        default:
            return configureRankNone()
        }
    }
}
