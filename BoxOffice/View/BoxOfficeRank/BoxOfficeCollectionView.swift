//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/10.
//

import UIKit

class BoxOfficeCollectionView: UICollectionView {

    private var layout: UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        return layout
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = self.layout

        let cell = CustomListCell.self
        self.register(cell: cell)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
