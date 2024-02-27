import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieAPIFetcher().fetchBoxOffice(targetDate: "20240219")
        MovieAPIFetcher().fetchDetailMovieInfo(movieCode: "20231415")
        checkJSONLoader()
    }
    
    func checkJSONLoader() {
        do {
            let movie: BoxOfficeResponse = try JSONLoader().loadJSONFromFile(from: .main, fileName: "box_office_sample")
            dump(movie)
        } catch {
            print(error.localizedDescription)
        }
    }
}


