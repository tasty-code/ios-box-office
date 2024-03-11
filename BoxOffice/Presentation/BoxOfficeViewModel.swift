//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import Foundation

final class BoxOfficeViewModel: ViewModelType {
    
    private let boxOfficeUseCase: BoxOfficeUseCase
    private var boxOfficeData: Observable<[BoxOfficeEntity]> = Observable([])
    private var networkError: Observable<Bool> = Observable(false)
    
    init(boxOfficeUseCase: BoxOfficeUseCase) {
        self.boxOfficeUseCase = boxOfficeUseCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshAction: Observable<Void>
    }
    
    struct Output {
        let boxOfficeData: Observable<[BoxOfficeEntity]>
        let networkError: Observable<Bool>
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
        
        return Output(boxOfficeData: boxOfficeData, networkError: networkError)
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
            default:
                DispatchQueue.main.async {
                    self?.networkError.value = true
                }
            }
        }
    }
}
