//
//  MovieCollectionViewListCell.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/12.
//

import UIKit

class MovieCollectionViewListCell: UICollectionViewListCell {
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let rankStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let rankStatusImage = UIImageView()
    
    lazy var rankStatusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.addArrangedSubview(rankStatusImage)
        stackView.addArrangedSubview(rankStatusLabel)
        return stackView
    }()
    
    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(rankStatusStackView)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLayout()
    }
    
    func configureLayout() {
        accessories = [.disclosureIndicator()]
        accessories.append(.customView(configuration: .init(customView: leftStackView, placement: .leading())))
    }
    
    func update(movie: MovieDTO) {
        rankLabel.text = movie.rank
        rankStatusLabel.text = movie.rankInten
        
        if movie.rankOldAndNew == "NEW" {
            rankStatusLabel.text = "신작"
            rankStatusLabel.textColor = .systemRed
        }
        else {
            if movie.rankInten == "0" {
                rankStatusLabel.text = "-"
                rankStatusStackView.removeArrangedSubview(rankStatusImage)
            }
            else if movie.rankInten.hasPrefix("-") {
                rankStatusLabel.text = movie.rankInten.replacingOccurrences(of: "-", with: "")
                rankStatusImage.image = UIImage(systemName: "arrowtriangle.up.fill")
                rankStatusImage.tintColor = .systemRed
            }
            else {
                rankStatusLabel.text = movie.rankInten
                rankStatusImage.image = UIImage(systemName: "arrowtriangle.down.fill")
                rankStatusImage.tintColor = .systemBlue
            }
        }
        
        var config = self.defaultContentConfiguration()
        
        let todayCount = movie.audienceCount.formatDecimal() ?? ""
        let totalCount = movie.audienceAcc.formatDecimal() ?? ""

        config.text = movie.name
        config.secondaryText = "오늘 \(todayCount) / 총 \(totalCount)"
        config.textProperties.font = .preferredFont(forTextStyle: .title3)
        config.secondaryTextProperties.font = .preferredFont(forTextStyle: .subheadline)
        
        // 설정 완료
        self.contentConfiguration = config
    }
    
}

fileprivate extension String {
    
    func formatDecimal() -> String? {
        guard let number = Int(self) else {
            return nil
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
}
