
import UIKit

final class MovieStackView: UIStackView {
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieStackView {
   private func setupStackView() {
        self.axis = .vertical
        self.spacing = 0
        self.distribution = .fillEqually
        self.alignment = .leading
    }
}

extension MovieStackView {
    private func formatNumber(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .decimal
          return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    func configureMovieStackView(todayAdience: Int, movieName: String, totalAdience: Int) {
        let todayAudience = formatNumber(todayAdience)
        let totalAudience = formatNumber(totalAdience)
        self.movieNameLabel.text = movieName
        self.audienceLabel.text = "오늘\(todayAudience) / 총\(totalAudience)"
        self.addArrangedSubview(movieNameLabel)
        self.addArrangedSubview(audienceLabel)
    }
}

