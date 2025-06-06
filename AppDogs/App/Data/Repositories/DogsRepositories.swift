//
//  DogsRepositories.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class DogsRepositories: DogsRepositoriesType {
    private(set) var networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func getDogs() async throws -> [DogObject] {
        let endPoint = NetworkRequest<[APIDogResponse]>(
            method: .GET,
            relativePath: DataConstants.Ws.getDogs,
            parameters: nil
        )
        do {
            let data = try await networkService.request(endPoint, queue: .main)
            return DogsMapper.map(input: data)
        }
        catch {
            throw error
        }
    }
}
