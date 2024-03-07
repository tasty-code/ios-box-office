import UIKit

class BoxOfficeListViewController: UIViewController {
    private var movieAPIFetcher: MovieAPIFetcher
    
    
    init(fetcher: MovieAPIFetcher) {
        self.movieAPIFetcher = fetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         

    }
    
}


