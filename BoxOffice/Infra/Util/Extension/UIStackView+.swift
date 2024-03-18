import UIKit

extension UIStackView {
    func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = .fill
        stackView.spacing = CGFloat(spacing)
        return stackView
    }
}
