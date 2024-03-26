//
//  LoadingView.swift
//  BoxOffice
//
//  Created by Jin-Mac on 3/20/24.
//

import UIKit

final class LoadingView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .systemIndigo
        return view
    }()
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Loading..."
        return label
    }()
    
    var isLoading = false {
        didSet {
            self.isHidden = self.isLoading == false
            self.isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backgroundView)
        self.addSubview(self.activityIndicatorView)
        self.addSubview(self.loadingLabel)
        
        NSLayoutConstraint.activate([
            self.backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            self.loadingLabel.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor),
            self.loadingLabel.topAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor, constant: 50)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
