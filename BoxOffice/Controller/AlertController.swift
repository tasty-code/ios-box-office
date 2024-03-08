//
//  AlertController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/21/24.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(with error: NetworkError) {
        let terminateMessage: String = "알 수 없는 오류가 발생하였습니다. 빠르게 수정하도록 하겠습니다."
        let serverErrorMessage: String = "일시적인 서버 오류로 데이터를 불러오지 못했습니다. 잠시 후에 다시 시도해주세요."
        
        let message: String
        let action: UIAlertAction
        
        switch error {
        case .serverError:
            message = serverErrorMessage
            action = UIAlertAction(title: "확인", style: .default)
        default:
            message = terminateMessage
            action = UIAlertAction(title: "확인", style: .default) { _ in
                DispatchQueue.main.async {
                    self.view = TemporaryUnavailableView()
                }
            }
        }
        
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        self.present(alertViewController, animated: true)
    }
}
