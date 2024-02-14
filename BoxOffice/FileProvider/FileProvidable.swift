import Foundation

protocol FileProvidable {
  func getData(
    from fileName: String,
    extension fileExtension: FileExtension
  ) throws -> Data
}
