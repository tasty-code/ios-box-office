//
//  ActivityIndicatorView.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/12.
//

import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.center = CGPoint(x: frame.midX, y: frame.midY)
        self.startAnimating()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
