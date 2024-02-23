
protocol MovieRepositoryProtocol {
    func requestBoxofficeData() async -> Result<BoxOfficeDTO, NetworkError>
    func requestDetailMovieData() async -> Result<DetailMovieInfoDTO, NetworkError>
}
