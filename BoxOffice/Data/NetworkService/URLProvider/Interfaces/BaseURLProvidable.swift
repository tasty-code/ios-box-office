
import Foundation

protocol BaseURLProvidable {
    func get(for type: BaseURLType) -> URL?
}
