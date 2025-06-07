//
//  SearchDogsView.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Resolver
import SwiftUI
import SkeletonUI

struct SearchDogsView<ViewModelType>: View where ViewModelType: SearchDogsViewModelType {
    @ObservedObject var viewModel: ViewModelType = Resolver.resolve()
    
    var body: some View {
        NavigationStack {
            SkeletonList(with: viewModel.state.searchText.isEmpty ? viewModel.state.dogs : viewModel.state.searchDogs ,
                         quantity: viewModel.state.numberSkeletonCell) { loading, dog in
                DogCellView(dogObject: dog, loading: loading)
                    .frame(height: 180)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
                         .background(.colorGrayLight)
                         .scrollContentBackground(.hidden)
                         .navigationBarTitle(SearchDogsState.Constants.title, displayMode: .inline)
                         .searchable(
                            text: $viewModel.state.searchText,
                            placement: .navigationBarDrawer(displayMode: .always)
                         )
                         .textInputAutocapitalization(.never)
                         .onChange(of: viewModel.state.searchText) {
                             viewModel.searchDogs(query: viewModel.state.searchText)
                         }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisAppear()
        }
        .alert(isPresented: $viewModel.state.alert) {
            Alert(
                title: Text(SearchDogsState.Constants.error),
                message: Text(SearchDogsState.Constants.errorMessage),
                dismissButton: .cancel(Text(SearchDogsState.Constants.accept)))
        }
    }
}
