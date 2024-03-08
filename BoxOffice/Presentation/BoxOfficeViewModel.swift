//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import Foundation

final class BoxOfficeViewModel: ViewModelType {
    
    private let boxOfficeUseCase: BoxOfficeUseCase
    var boxOfficeData: Observable<[BoxOfficeEntity]> = Observable([])
    
    init(boxOfficeUseCase: BoxOfficeUseCase) {
        self.boxOfficeUseCase = boxOfficeUseCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshAction: Observable<Void>
    }
    
    struct Output {
        let boxOfficeData: Observable<[BoxOfficeEntity]>
    }
    
    func transform(input: Input) -> Output {
        let yesterday = Date.convertYesterdayDateToString()
        input.viewDidLoad
            .subscribe { [weak self] in
                self?.updateBoxOfficeList(yesterday: yesterday)
            }
        
        input.refreshAction
            .subscribe { [weak self] in
                self?.updateBoxOfficeList(yesterday: yesterday)
            }
        
        return Output(boxOfficeData: boxOfficeData)
    }
}

extension BoxOfficeViewModel {
    
    private func updateBoxOfficeList(yesterday: String) {
        boxOfficeUseCase.execute(yesterday: yesterday) { [weak self] result in
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
