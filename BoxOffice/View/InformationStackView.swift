//
//  InformationStackView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

final class InformationStackView: UIStackView {
    let titleLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
    let contentLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .body), textAlignment: .left)
    
    init(titleText: String) {
        super.init(frame: .zero)
        titleLabel.text = titleText
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(contentLabel)
        
        contentLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
}
