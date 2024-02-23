
protocol MovieRepositoryProtocol {
    func requestBoxofficeData() async -> Result<BoxOfficeDTO, NetworkError>
}
