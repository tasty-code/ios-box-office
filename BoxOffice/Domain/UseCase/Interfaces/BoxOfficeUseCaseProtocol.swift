
import Foundation

protocol BoxOfficeUseCaseProtocol {
    func fetchBoxOfficeData() async -> Result<[BoxOfficeMovie], DomainError>
}
