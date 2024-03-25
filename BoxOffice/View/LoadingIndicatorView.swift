//
//  LoadingIndicatorView.swift
//  BoxOffice
//
//  Created by 강창현 on 3/14/24.
//

import UIKit

enum LoadingIndicatorView {
    static func showLoading(in view: UIView) {
            DispatchQueue.main.async {
                let loadingIndicatorView: UIActivityIndicatorView
                guard
                    let existedView = view.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView
                else {
                    loadingIndicatorView = UIActivityIndicatorView()
                    loadingIndicatorView.frame = view.frame
                    loadingIndicatorView.center = CGPoint(
                        x: view.frame.width / 2,
                        y: view.frame.height / 2 + view.bounds.origin.y
                    )
                    view.addSubview(loadingIndicatorView)
                    loadingIndicatorView.startAnimating()
                    return
                }
                loadingIndicatorView = existedView
                loadingIndicatorView.startAnimating()
            }
        }

    static func hideLoading(in view: UIView) {
            DispatchQueue.main.async {
                view.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
            }
        }
}
