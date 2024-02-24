final class BoxOfficeViewModel {
  private let useCase: MovieUseCaseProtocol
  
  weak var delegate: BoxOfficeOutput?
  
  private var yesterDayBoxOfficeList: [DailyBoxOffice.ListItem] {
    didSet {
      self.delegate?.updateBoxOffice()
    }
  }
  
  private var isFetching: Bool {
    didSet {
      self.delegate?.updateLoadingStatus()
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
    self.isFetching = false
    self.errorState = nil
  }
}

extension BoxOfficeViewModel: BoxOfficeInput {
  func viewDidLoad() {
    fetchYesterdayBoxOffice()
  }
  
  func pullToRefresh() {
    fetchYesterdayBoxOffice()
  }
}

extension BoxOfficeViewModel {
  private func fetchYesterdayBoxOffice() {
    Task {
      self.isFetching = true
      let result = await self.useCase.getDailyBoxOffice()
      switch result {
      case .success(let response):
        self.yesterDayBoxOfficeList = response.list
      case .failure(let error):
        self.errorState = error.localizedDescription
      }
      self.isFetching = false
    }
  }
}
