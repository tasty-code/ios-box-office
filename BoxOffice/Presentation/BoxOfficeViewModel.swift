//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import Foundation

final class BoxOfficeViewModel: ViewModelType {
    
    private let boxOfficeRepository: BoxOfficeRepository
    var boxOfficeData: Observable<[BoxOfficeEntity]> = Observable([])
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshAction: Observable<Void>
    }
    
    struct Output {
        let boxOfficeData: Observable<[BoxOfficeEntity]>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad
            .subscribe { [weak self] in
                self?.updateBoxOfficeList()
            }
        
        input.refreshAction
            .subscribe { [weak self] in
                self?.updateBoxOfficeList()
            }
        
        return Output(boxOfficeData: boxOfficeData)
    }
}

extension BoxOfficeViewModel {
    
    private func updateBoxOfficeList() {
        boxOfficeRepository.fetchBoxOfficeData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.boxOfficeData.value = data
                }
            case .failure(let error):
                // TODO: 에러처리 필요
                print(error.localizedDescription)
            }
        }
    }
}
