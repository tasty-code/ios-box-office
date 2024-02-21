//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController, DateFormattable {

    let boxOfficeListView: UIView = BoxOfficeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = boxOfficeListView
        configureNavigation()
    }
    
    func configureNavigation() {
        guard 
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        title = makeDataFormatToString(date: yesterday, format: "yyyy-MM-dd")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MovieCollectionCell()
        return cell
    }
}
