
import UIKit

extension UIViewController {
        
    // MARK: - Handle Number
    func numberFormatter(for data: String) -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: NSNumber(value: Double(data) ?? 0)) else { return "error" }
        return result
    }

    
    // MARK: - Alert Controller
    func presentAlert(title: String,
                      message: String,
                      confirmTitle: String,
                      confirmAction: ((UIAlertAction) -> Void)? = nil,
                      completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        alertViewController.addAction(confirmAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }

}


