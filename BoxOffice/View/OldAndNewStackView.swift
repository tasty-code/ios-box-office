import UIKit

class OldAndNewStackView: UIStackView {
    
    private let rankStackView  = RankStackView()
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let newMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "신작"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

