import UIKit

class RankStackView: UIStackView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let oldRankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let rankUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .red
        return imageView
    }()
    
    private let rankDownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = .blue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
