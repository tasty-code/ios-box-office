
protocol MovieRepositoryProtocol {
    func getBoxofficeData() async -> Result<BoxOfficeDTO, NetworkError>
    func getMovieList() async
    func getMovieInfo() async
}
