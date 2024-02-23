import Foundation

protocol NetworkRequestable {
  func requestData(builder: NetworkRequestBuilderProtocol) async -> Result<Data, NetworkServiceError>
}
