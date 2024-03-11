
import Foundation

protocol Mappable {
    associatedtype Entity
    func toEntity() -> Entity
}
