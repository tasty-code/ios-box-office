import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}

class MoviesListCell: UICollectionViewCell {
    private let titleLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .black)
    private let rankLabel = UILabel(font: .boldSystemFont(ofSize: 25), textColor: .black)
    private let changeLabel = UILabel(font: .systemFont(ofSize: 13), textColor: .red)
    private let audienceLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(rankLabel)
        addSubview(changeLabel)
        addSubview(audienceLabel)
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor, constant: 40)
        ])
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 3),
            changeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            audienceLabel.leadingAnchor.constraint(equalTo: changeLabel.trailingAnchor, constant: 30)
        ])
    }
    
    func configure(with movie: MovieBoxOffice) {
        titleLabel.text = movie.movieName
        rankLabel.text = "\(movie.rank)"
        changeLabel.text = "\(movie.rankChangesWithPreviousDay)"
        audienceLabel.text = formatAudienceLabel(with: movie)
        formatChangeLabel(with: movie)
    }
    
    private func formatAudienceLabel(with movie: MovieBoxOffice) -> String {
        if let formattedAudienceCount = numberFormatter.string(from: NSNumber(value: movie.audienceCount)),
           let formattedAccumulation = numberFormatter.string(from: NSNumber(value: movie.audienceAccumulation)) {
            return "오늘 \(formattedAudienceCount) / 총 \(formattedAccumulation)"
        }
        return "오늘 \(movie.audienceCount) / 총 \(movie.audienceAccumulation)"
    }
    
    private func formatChangeLabel(with movie: MovieBoxOffice) {
        if movie.rankChangesWithPreviousDay > 0 {
            changeLabel.text = "↑ \(movie.rankChangesWithPreviousDay)"
            changeLabel.textColor = .red
        } else if movie.rankChangesWithPreviousDay < 0 {
            changeLabel.text = "↓ \(abs(movie.rankChangesWithPreviousDay))"
            changeLabel.textColor = .blue
        } else {
            changeLabel.text = "-"
            changeLabel.textColor = .black
        }
        if movie.rankOldAndNew == .new {
            changeLabel.text = "신작"
            changeLabel.textColor = .red
        }
    }
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

/*
 extension UILabel {
     convenience init(font: UIFont, textColor: UIColor) {
         self.init()
         self.font = font
         self.textColor = textColor
     }
 }

 class MoviesListCell: UICollectionViewCell {
     private let titleLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .black)
     private let rankLabel = UILabel(font: .boldSystemFont(ofSize: 25), textColor: .black)
     private let changeLabel = UILabel(font: .systemFont(ofSize: 13), textColor: .red)
     private let audienceLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .gray)
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     private func setupViews() {
         addSubview(titleLabel)
         addSubview(rankLabel)
         addSubview(changeLabel)
         addSubview(audienceLabel)
         
         rankLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
             rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
         ])
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
             titleLabel.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor, constant: 40)
         ])
         changeLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             changeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 3),
             changeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
         ])
         audienceLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             audienceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
             audienceLabel.leadingAnchor.constraint(equalTo: changeLabel.trailingAnchor, constant: 30)
         ])
     }
     
     func configure(with viewModel: MoviesCellViewModel) {
         titleLabel.text = viewModel.movieName
         rankLabel.text = viewModel.rank
         changeLabel.text = viewModel.rankChangeText
         changeLabel.textColor = viewModel.rankChangeColor
         audienceLabel.text = viewModel.audienceText
     }
 }

 */
