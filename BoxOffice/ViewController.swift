import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        checkJSONLoader()
    }
    
    func checkJSONLoader() {
        do {
            let movie: BoxOffice? = try JSONLoader().loadJSON(from: .main, fileName: "box_office_sample")
            dump(movie)
        } catch {
            print(error.localizedDescription)
        }
    }
}

