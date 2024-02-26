//
//  NetworkBuilderProtocol.swift
//  BoxOffice
//
//  Created by Roh on 2/21/24.
//

import Foundation

protocol NetworkRequestBuilderProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var header: [String: String] { get }
    var query: [String: Any] { get }
    var body: [String: Any] { get }
    var method: HTTPMethodType { get }
    var bodyEncoder: Encoderable { get }
    var urlScheme: URLScheme { get }
    func setURLRequest() -> URLRequest?
}

extension NetworkRequestBuilder {
    var bodyEncoder: Encoderable {
        JsonEncoder()
    }
}
