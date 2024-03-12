
import Foundation

protocol Mappable {
    associatedtype Entity
    func toEntity() -> Entity
}

protocol ErrorMappable {
    func mapToDomainError() -> DomainError
}
