//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

class MovieInformationViewController: UIViewController {
    
    let movieInformationView: MovieInformationView = MovieInformationView()
    let movieCode: String
    
    private lazy var dataSource: any LoadDataProtocol = {
       let dataSource = MovieInformation(movieCode: movieCode)
        dataSource.delegate = self
        return dataSource
    }()

    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
           await loadInformation()
        }
       
    }
    
    override func loadView() {
        view = movieInformationView
        view.backgroundColor = .white
    }
}

extension MovieInformationViewController: DataDelegate {
    func reloadView() {
        guard let data = dataSource.loadedData as? MovieInformation.MovieDetail else {
            return
        }
        DispatchQueue.main.async {
            self.movieInformationView.insertData(data: data)
        }
    }
}

extension MovieInformationViewController {
    func loadInformation() async {
        do {
            try await self.dataSource.loadData()
        } catch {
            print(error)
        }
           
    }
}
