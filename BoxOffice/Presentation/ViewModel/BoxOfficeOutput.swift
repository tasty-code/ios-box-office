protocol BoxOfficeOutput: AnyObject {
  func updateBoxOffice()
  func updateLoadingStatus()
  func showError(message: String)
}
