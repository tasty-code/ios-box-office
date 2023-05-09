//
//  BoxOfficeBrief.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

final class BoxOfficeBrief: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        configurationOfComponents()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configuration()
        configurationOfComponents()
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
    
    private func configuration() {
        axis = .vertical
        alignment = .leading
        distribution = .fillEqually
    }
    
    private func configurationOfComponents() {
        addArrangedSubview(movieName)
        addArrangedSubview(audienceCount)
    }
}

extension BoxOfficeBrief {
    func setMovieName(by text: String) {
        movieName.text = text
    }
    
    func setAudienceCount(by text: String) {
        audienceCount.text = text
    }
}
