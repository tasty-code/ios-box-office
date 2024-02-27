final class BoxOfficeViewModel {
  private let useCase: MovieUseCaseProtocol
  
  weak var delegate: BoxOfficeOutput?
  
  private var title: String? {
    didSet {
      self.delegate?.updateTitle(with: title)
    }
  }
  
  private var yesterDayBoxOfficeList: [DailyBoxOffice.ListItem] {
    didSet {
      self.delegate?.updateBoxOffice(items: yesterDayBoxOfficeList)
    }
  }
  
  private var errorState: String? {
    didSet {
      guard let errorState else { return }
      self.delegate?.showError(message: errorState)
    }
  }
  
  init(
    useCase: MovieUseCaseProtocol
  ) {
    self.useCase = useCase
    self.yesterDayBoxOfficeList = []
    self.errorState = nil
  }
}

extension BoxOfficeViewModel: BoxOfficeInput {
  func viewDidLoad() {
    getTitle()
    fetchYesterdayBoxOffice()
  }
  
  func pullToRefresh() {
    fetchYesterdayBoxOffice()
  }
}

import Foundation

extension BoxOfficeViewModel {
  private func getTitle() {
    let title = self.useCase.getTitle()
    self.title = title
  }
  
  private func fetchYesterdayBoxOffice() {
    Task {
      let result = await self.useCase.getDailyBoxOffice()
      switch result {
      case .success(let response):
        self.yesterDayBoxOfficeList = response.list
      case .failure(let error):
        self.errorState = error.localizedDescription
      }
    }
  }
}
