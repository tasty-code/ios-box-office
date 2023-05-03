//
//  DIContainer.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/04.
//

import Foundation

final class DIContainer {
    
    func makeBoxOfficeListController() -> BoxOfficeListController {
        let router = NetworkRouter()
        let manager = NetworkManager(router: router)
        let repository = BoxOfficeListRepository(manager: manager)
        let usecase = BoxOfficeListUsecase(repository: repository)
        let viewModel = BoxOfficeListViewModel(usecase: usecase)
        let viewController = BoxOfficeListController(viewModel: viewModel)
        return viewController
    }
}
