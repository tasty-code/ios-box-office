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
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private let movieName: UILabel = {
        let movieName = UILabel()

        return movieName
    }()

    private let audienceCount: UILabel = {
        let audienceCount = UILabel()

        return audienceCount
    }()
}
