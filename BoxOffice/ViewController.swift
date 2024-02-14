
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        guard let boxOffice = JsonDecoder<BoxOfficeData>().loadData(from: "BoxOfficeSample", of: "json") else {
            print("\(JsonParsingError.fileLoadError.errorMessage)")
            return
        }
        print(boxOffice)
    }
}

