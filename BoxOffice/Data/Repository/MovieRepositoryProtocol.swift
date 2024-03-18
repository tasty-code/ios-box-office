
protocol MovieRepositoryProtocol {
    func requestBoxOfficeData<T: Decodable>() async -> Result<T, NetworkError>
    func requestDetailMovieData<T: Decodable>(movieCode: String) async -> Result<T, NetworkError>
}


