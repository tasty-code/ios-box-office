protocol BoxOfficeOutput: AnyObject {
  func updateBoxOffice(items: [DailyBoxOffice.ListItem])
  func updateLoadingStatus()
  func showError(message: String)
}
