//
//  Module+Injection.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import Resolver
import SwiftData

extension Resolver {
    static func RegisterModuleDependencies (with baseUrl: String){
        registerData(with: baseUrl)
        registerDomain()
        registerPresentation()
    }
    
}

extension Resolver {
    
    static func registerData(with baseUrl: String) {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                DogModel.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        register {
            PersistenceService(container: sharedModelContainer)
        }.implements(PersistenceServiceType.self)
        
        register {
            PersistenceRepositories(persistenceService: resolve(PersistenceServiceType.self))
        }.implements(PersistenceRepositoriesType.self)
        
        register {
            URLSession(configuration: URLSession.configuration())
        }
        
        register {
            NetworkService(url: baseUrl, urlSession: resolve(URLSession.self), decoder: JSONDecoder())
        }.implements(NetworkServiceType.self)
        
        register {
            DogsRepositories(networkService: resolve(NetworkServiceType.self))
        }.implements(DogsRepositoriesType.self)
    }
    
    static func registerDomain() {
        register {
            FetchDogsModelUseCase(repository: resolve(PersistenceRepositoriesType.self))
        }
        .implements(AnyUseCase<Any?, [DogObject]>.self, name: "FetchDogsModelUseCase")

        register {
            GetDogsUseCase(repository: resolve(DogsRepositoriesType.self))
        }
        .implements(AnyUseCase<Any?, [DogObject]>.self, name: "GetDogsUseCase")

        register {
            SaveDogModelUseCase(repository: resolve(PersistenceRepositoriesType.self))
        }
        .implements(AnyUseCase<DogObject, Void>.self)

        register {
            SyncUseCase(
                fetchDogsModelUseCase: resolve(AnyUseCase<Any?, [DogObject]>.self, name: "FetchDogsModelUseCase"),
                getDogsUseCase: resolve(AnyUseCase<Any?, [DogObject]>.self, name: "GetDogsUseCase"),
                saveDogModelUseCase: resolve(AnyUseCase<DogObject, Void>.self)
            )
        }
        .implements(AnyUseCase<Any?, [DogObject]>.self, name: "SyncUseCase")
    }
    
    static func registerPresentation() {
        register(SearchDogsViewModel.self){ _ in
            return SearchDogsViewModel(syncUseCase: resolve(AnyUseCase<Any?, [DogObject]>.self, name: "SyncUseCase"))
        }
    }
}
