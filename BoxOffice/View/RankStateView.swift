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
    
    private var rankStateImage = UIImageView()
    
    private let rankUpImage: UIImage? = {
        let image = UIImage(
            systemName: "arrowtriangle.up.fill"
        )?.withTintColor(
            .systemRed,
            renderingMode: .alwaysOriginal
        )
        return image
    }()
    
    private let rankDownImage: UIImage? = {
        let image = UIImage(
            systemName: "arrowtriangle.down.fill"
        )?.withTintColor(
                .systemBlue,
                renderingMode: .alwaysOriginal
            )
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupConstraints()
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
        self.addArrangedSubview(rankStateImage)
        self.addArrangedSubview(rankStateLabel)
    }
    
    func setupConstraints() {
        rankStateImage.translatesAutoresizingMaskIntoConstraints = false
        rankStateImage.heightAnchor.constraint(equalTo: rankStateLabel.heightAnchor).isActive = true
    }

    func setRankStateView(rankState: String) -> [String? : UIImage?] {
        guard
            let intRankState = Int(rankState)
        else {
            return [nil: nil]
        }
        self.rankStateLabel.textColor = .black
        switch intRankState {
        case let state where 0 < state :
            return [String(state): rankUpImage]
        case let state where state < 0 :
            return [String(abs(state)): rankDownImage]
        default :
            return ["-": nil]
        }
    }
}

extension RankStateView {
    func configureRankState(rankState: String, rankChanged: String) {
        guard 
            rankState != "NEW"
        else {
            self.rankStateLabel.textColor = .systemRed
            self.rankStateLabel.text = "신작"
            return
        }
        
        _ = setRankStateView(rankState: rankChanged).map { (key: String?, value: UIImage?) in
            self.rankStateLabel.text = key
            guard
                let rankImageView = value
            else {
                rankStateImage.isHidden = true
                return
            }
            rankStateImage.isHidden = false
            self.rankStateImage.image = rankImageView
        }
    }
}
