//
//  DIContainer.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/04.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
    
    func makeBoxOfficeListController() -> BoxOfficeListController {
        let router = NetworkRouter()
        let repository = BoxOfficeRepository(router: router)
        let usecase = FetchBoxOfficeUsecase(repository: repository)
        let viewModel = BoxOfficeListViewModel(usecase: usecase)
        let viewController = BoxOfficeListController(viewModel: viewModel)
        return viewController
    }
}
