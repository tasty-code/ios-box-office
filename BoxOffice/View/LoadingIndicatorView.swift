//
//  LoadingIndicatorView.swift
//  BoxOffice
//
//  Created by 강창현 on 3/14/24.
//

import UIKit

struct LoadingIndicatorView {
    static func showLoading() {
            DispatchQueue.main.async {
                guard
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let window = windowScene.windows.last
                else {
                    return
                }
                let loadingIndicatorView: UIActivityIndicatorView
                guard
                    let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView
                else {
                    loadingIndicatorView = UIActivityIndicatorView()
                    loadingIndicatorView.frame = window.frame
                    window.addSubview(loadingIndicatorView)
                    loadingIndicatorView.startAnimating()
                    return
                }
                loadingIndicatorView = existedView
                loadingIndicatorView.startAnimating()
            }
        }

        static func hideLoading() {
            DispatchQueue.main.async {
                guard
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let window = windowScene.windows.last
                else {
                    return
                }
                window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
            }
        }
}
