//
//  ReusedDetailStackView.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

final class ReusedDetailStackView: UIStackView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .body, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraint()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupStackView(title: String, contents: [String]) {
        titleLabel.text = title
        guard 
            !contents.isEmpty
        else {
            contentLabel.text = "-"
            return
        }
        var textList: String = ""
        for (index, text) in contents.enumerated() {
            textList.append(text)
            if index != contents.endIndex - 1 {
                textList.append(", ")
            }
        }
        contentLabel.text = textList
    }
}

private extension ReusedDetailStackView {
    private func configure() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(contentLabel)
        self.axis = .horizontal
        self.alignment = .leading
        self.distribution = .fill
        self.spacing = 5
    }
    
    private func setupConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 6).isActive = true
    }
}
