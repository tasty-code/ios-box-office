final class BoxOfficeViewModel {
  private let useCase: BoxOfficeUseCaseProtocol
  
  weak var delegate: BoxOfficeOutput?
  
  private var title: String? {
    didSet {
      self.delegate?.updateTitle(with: title)
    }
  }
  
  private var yesterDayBoxOffice: [DailyBoxOffice.ListItem] {
    didSet {
      self.delegate?.updateBoxOffice(items: yesterDayBoxOffice)
    }
  }
  
  private var errorState: String? {
    didSet {
      guard let errorState else { return }
      self.delegate?.showError(message: errorState)
    }
  }
  
  init(
    useCase: BoxOfficeUseCaseProtocol
  ) {
    self.useCase = useCase
    self.yesterDayBoxOffice = []
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
    self.title = self.useCase.getTitle()
  }
  
  private func fetchYesterdayBoxOffice() {
    Task {
      let result = await self.useCase.getDailyBoxOffice()
      switch result {
      case .success(let response):
        self.yesterDayBoxOffice = response.list
      case .failure(let error):
        self.errorState = error.localizedDescription
      }
    }
  }
}
