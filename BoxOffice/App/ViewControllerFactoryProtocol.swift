
import UIKit

protocol ViewControllerFactoryProtocol {
    func makeViewController(for type: ViewControllerType) -> UIViewController
}
