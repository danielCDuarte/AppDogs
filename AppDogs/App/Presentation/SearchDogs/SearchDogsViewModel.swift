//
//  SearchDogsViewModel.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Combine
import Resolver
import Foundation

final class SearchDogsViewModel: BaseViewModel {
    private var dogs: [DogObject]?
    private var subscribers: Set<AnyCancellable> = []
    @Published var state = SearchDogsState()
    
    private let syncUseCase: AnyUseCase< Any?, [DogObject]>
    
    init(syncUseCase:AnyUseCase< Any?, [DogObject]>) {
            self.syncUseCase = syncUseCase
            super.init()
            errorHandler = self
    }
    
    private func syncDogs() async {
        do {
            let result = try await syncUseCase.execute(params: nil)
            await MainActor.run {
                self.bindDogs(result)
            }
        } catch let error {
            await MainActor.run {
                self.showError(error: error)
            }
        }
    }
    
    private func bindDogs(_ dogsObject: [DogObject]) {
        dogs = dogsObject
        state.dogs = dogsObject
        state.isLoading = false
        objectWillChange.send()
    }
    
    private func searchDogs(by query: String) {
        let filterResults = dogs?.filter { dog in
            dog.name.lowercased().contains(query.lowercased())
        } ?? []
        state.searchDogs = filterResults
        state.isLoading = false
        objectWillChange.send()
    }
    
}

extension SearchDogsViewModel: SearchDogsViewModelType {
    func searchDogs(query: String) {
        searchDogs(by: query)
    }
    
    func onAppear() {
        Task {
            await syncDogs()
        }
    }
    
    func onDisAppear() {
        loading = false
    }
    
}

extension SearchDogsViewModel: BaseView {
    func showError(error: Error) {
        state.alert = true
        objectWillChange.send()
    }
}
