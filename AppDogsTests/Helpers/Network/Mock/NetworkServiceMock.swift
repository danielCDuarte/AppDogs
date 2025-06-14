//
//  NetworkServiceMock.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

@testable import AppDogs

final class NetworkServiceMock {
    static var error: Error?
    static var response: AnyObject!
}

extension NetworkServiceMock: NetworkServiceType {
    func setBaseUrl(_ baseUrl: String) {
        debugPrint(baseUrl)
    }
    
    func request<Response>(
        _ endpoint: NetworkRequest<Response>,
        queue: DispatchQueue) async throws -> Response where Response: Decodable {
        var respObject: Response! = nil
       
        if NetworkServiceMock.response != nil {
            respObject = NetworkServiceMock.response as? Response
           
        }
        if let error = NetworkServiceMock.error {
            throw error
        }
        return respObject
    }
    
}
