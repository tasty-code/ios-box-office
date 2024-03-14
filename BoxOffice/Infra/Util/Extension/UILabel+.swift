import UIKit

extension UILabel {
    func makeDetailLabel(text: String? = nil, textAlignment: NSTextAlignment, bold: Bool, numberOfLines: Int? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = bold ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = textAlignment
        if let numberOfLines = numberOfLines {
            label.numberOfLines = numberOfLines
        }
        return label
    }
    
    func makeCellLabel(fontSize: Int, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(fontSize))
        label.textColor = textColor
        return label
    }
}
