enum MovieUseCaseError: Error {
  case cannotConvertToDomain
  case otherLayerError(Error)
}
