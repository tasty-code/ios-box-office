
import UIKit

final class BoxOfficeCollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        guard 
            let boxOffice = try? JsonDecoder<BoxOfficeData>().loadData(from: "BoxOfficeSample", of: "json")
        else {
            return
        }
        print(boxOffice)
    }
}

