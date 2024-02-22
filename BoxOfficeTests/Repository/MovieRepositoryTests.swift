import XCTest
@testable import BoxOffice

final class MovieRepositoryImplTests: XCTestCase {
  typealias Session = MockURLSession
  
  private var sut: MovieRepository! = nil
  
  override func tearDownWithError() throws {
    self.sut = nil
  }
  
  func test_유효한_날짜문자열이_주어졌을때_getDailyBoxOffice를_호출하면_SearchDailyBoxOffice인스턴스를_가져온다() async throws {
    // given
    let dateString = Session.validDateString
    let session = Session(apiType: .searchDailyBoxOffice(dateString: dateString))
    let requester = MockNetworkService(requester: session)
    let decoder = JSONDecoder()
    self.sut = MovieRepository(requester: requester, decoder: decoder)
    
    // when
    let result = await self.sut.getDailyBoxOffice(dateString: dateString)
    
    // then
    switch result {
    case .success(let success):
      XCTAssertNotNil(success)
    case .failure:
      XCTFail("실패")
    }
  }
  
  func test_유효하지_날짜문자열이_주어졌을때_getDailyBoxOffice를_호출하면_실패를_리턴한다() async throws {
    // given
    let dateString = "in" + Session.validDateString
    let session = Session(apiType: .searchDailyBoxOffice(dateString: dateString))
    let requester = MockNetworkService(requester: session)
    let decoder = JSONDecoder()
    self.sut = MovieRepository(requester: requester, decoder: decoder)
    
    // when
    let result = await self.sut.getDailyBoxOffice(dateString: dateString)
    
    // then
    switch result {
    case .success(let success):
      XCTFail("실패")
    case .failure(let error):
      XCTAssertNotNil(error)
    }
  }
  
  func test_유효한_영화코드가_주어졌을때_getMovieDetail를_호출하면_SearchMovieInfo인스턴스를_가져온다() async throws {
    // given
    let codeString = Session.validCodeString
    let session = Session(apiType: .searchMovieInfo(code: codeString))
    let requester = MockNetworkService(requester: session)
    let decoder = JSONDecoder()
    self.sut = MovieRepository(requester: requester, decoder: decoder)
    
    // when
    let result = await self.sut.getMovieDetail(movieCode: codeString)
    
    // then
    switch result {
    case .success(let success):
      XCTAssertNotNil(success)
    case .failure:
      XCTFail("실패")
    }
  }
  
  func test_유효하지않은_영화코드가_주어졌을때_getMovieDetail를_실패를_리턴한다() async throws {
    // given
    let codeString = "in" + Session.validCodeString
    let session = Session(apiType: .searchMovieInfo(code: codeString))
    let requester = MockNetworkService(requester: session)
    let decoder = JSONDecoder()
    self.sut = MovieRepository(requester: requester, decoder: decoder)
    
    // when
    let result = await self.sut.getMovieDetail(movieCode: codeString)
    
    // then
    switch result {
    case .success(let success):
      XCTFail("실패")
    case .failure(let error):
      XCTAssertNotNil(error)
    }
  }
}
