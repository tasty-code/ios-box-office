//
//  MovieStackView.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import UIKit

final class MovieStackView: UIStackView {
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let movieAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieStackView {
    func setupStackView() {
        self.axis = .vertical
        self.spacing = 0
        self.distribution = .fillEqually
        self.alignment = .leading
    }
}

extension MovieStackView {
    func configureStackView(movieName: String, totalAudience: String, todayAudience: String) {
        movieNameLabel.text = movieName
        guard
            let todayAudienceCount = Int(todayAudience),
            let totalAudienceCount = Int(totalAudience)
        else {
            return
        }
        movieAudienceLabel.text = "오늘 \(todayAudienceCount.numberFormatter()) / 총 \(totalAudienceCount.numberFormatter())"
        self.addArrangedSubview(movieNameLabel)
        self.addArrangedSubview(movieAudienceLabel)
    }
}
