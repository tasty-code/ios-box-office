
protocol MovieRepositoryProtocol {
    func getBoxofficeData() async -> Result<BoxOfficeDataDTO, NetworkError>
    func getMovieList() async
    func getMovieInfo() async
}
