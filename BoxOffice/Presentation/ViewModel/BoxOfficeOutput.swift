protocol BoxOfficeOutput: AnyObject {
  func updateTitle(with title: String?)
  func updateBoxOffice(items: [DailyBoxOffice.ListItem])
  func showError(message: String)
}
