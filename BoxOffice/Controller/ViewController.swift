import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Fetcher().fetchBoxOffice(targetDate: "20240219")
        Fetcher().fetchMovieInfo(movieCode: "20231415")
    }
}


