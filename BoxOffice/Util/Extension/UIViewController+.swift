//
//  UIViewController+.swift
//  BoxOffice
//
//  Created by EUNJU on 3/8/24.
//

import UIKit

extension UIViewController {
    
    /// 확인 버튼 하나만 있는 Alert 메서드
    func presentAlert(title: String,
                      message: String? = nil,
                      confirmTitle: String = "확인",
                      confirmAction: ((UIAlertAction) -> Void)? = nil,
                      completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        alertViewController.addAction(confirmAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
