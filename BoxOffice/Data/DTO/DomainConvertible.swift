protocol DomainConvertible {
  associatedtype Domain
  
  func toDomain() throws -> Domain
}
