//
//  TemporaryUnavailableView.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/08.
//

import UIKit

final class TemporaryUnavailableView: UIView {
    private var messageLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.messageLabel.numberOfLines = 2
        self.messageLabel.text = "해당 탭은 임시적으로 사용이 불가합니다.\n불편을 드려 죄송합니다."
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}
