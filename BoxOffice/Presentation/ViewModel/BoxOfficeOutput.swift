protocol BoxOfficeOutput: AnyObject {
  func updateBoxOffice(items: [DailyBoxOffice.ListItem])
  func showError(message: String)
}
