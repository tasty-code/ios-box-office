//
//  CollectionViewLayout.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/10.
//

import UIKit

struct CollectionViewLayout {
    
    static func create() -> UICollectionViewLayout {
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
}
