//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font  = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        return label
    }()
    
    let rankStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "신작"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "경관의 피"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .left
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "ddd/ddd"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .left
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let rankStackView: UIStackView = {
        let rankStackView = UIStackView()
        rankStackView.axis = .vertical
        rankStackView.distribution = .fillProportionally
        return rankStackView
    }()
    
    let informationStackView: UIStackView = {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.distribution = .fillProportionally
        return informationStackView
    }()
    
    private func setupSubView() {
        stackView.addSubview(rankStackView)
        stackView.addSubview(informationStackView)
        
        rankStackView.addSubview(rankLabel)
        rankStackView.addSubview(rankStatusLabel)
        
        informationStackView.addSubview(movieNameLabel)
        informationStackView.addSubview(audienceLabel)
    }
}
