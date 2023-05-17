//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/02.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewListCell {

    static let identifier = "MovieCell"

    private var rankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private var oldAndNewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private var audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()

    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, oldAndNewLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, audienceLabel])
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: Movie) {
        rankLabel.text = String(item.rank.rank)
        oldAndNewLabel.attributedText = rankStatusText(item.rank)
        titleLabel.text = item.name
        audienceLabel.text = audienceCountText(item.audience)
    }

    func setLayout() {
        accessories = [.disclosureIndicator()]
        contentView.addSubview(rankStackView)
        contentView.addSubview(informationStackView)

        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            rankStackView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.2),

            informationStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10),
            informationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    private func audienceCountText(_ audience: Audience) -> String {
        let todayCount = decimalFormatter(of: audience.today) ?? "-"
        let accumulateCount = decimalFormatter(of: audience.accumulate) ?? "-"
        return "오늘 \(todayCount) / 총 \(accumulateCount)"
    }

    private func decimalFormatter(of number: UInt) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number))
    }

    private func rankStatusText(_ rank: Rank) -> NSAttributedString {
        if rank.isEntry {
            return NSAttributedString(string: "신작", attributes: [.foregroundColor: UIColor.systemPink])
        }

        return varianceStatusText(of: rank.variance)
    }

    private func varianceStatusText(of variance: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()

        if variance > 0 {
            imageAttachment.image = UIImage(systemName: "arrowtriangle.up.fill")?.withTintColor(.systemRed)
            attributedString.append(NSAttributedString(string: String(variance)))
        } else if variance < 0 {
            imageAttachment.image = UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(.systemBlue)
            attributedString.append(NSAttributedString(string: String(abs(variance))))
        } else {
            imageAttachment.image = UIImage(systemName: "minus")?.withTintColor(.gray)
        }
        attributedString.insert(NSAttributedString(attachment: imageAttachment), at: 0)

        return attributedString
    }
}
