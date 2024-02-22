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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: - 숫자가 세 자리 이상 넘어가면 ,를 활용
    func configureStackView(movieName: String, totalAudience: String, todayAudience: String) {
        movieNameLabel.text = movieName
        movieAudienceLabel.text = "오늘 \(todayAudience) / 총 \(todayAudience)"
        self.addArrangedSubview(movieNameLabel)
        self.addArrangedSubview(movieAudienceLabel)
    }
}

private extension MovieStackView {
    func setupStackView() {
        self.axis = .vertical
        self.spacing = 0
        self.distribution = .fill
        self.alignment = .leading
    }
}
