//
//  SummaryInformationView.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

final class SummaryInformationView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfStackView()
        configureOfComponents()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureOfStackView()
        configureOfComponents()
    }
    
    private func configureOfStackView() {
        axis = .vertical
        alignment = .leading
        distribution = .fillEqually
    }
    
    private func configureOfComponents() {
        addArrangedSubview(movieName)
        addArrangedSubview(audienceCount)
    }
    
    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.font = .systemFont(ofSize: 20)
        movieName.textColor = .black
        return movieName
    }()

    private let audienceCount: UILabel = {
        let audienceCount = UILabel()
        audienceCount.font = .systemFont(ofSize: 15)
        audienceCount.textColor = .black
        return audienceCount
    }()
}

extension SummaryInformationView {
    func setMovieName(by text: String) {
        movieName.text = text
    }
    
    func setAudienceCount(by text: String) {
        audienceCount.text = text
    }
}
