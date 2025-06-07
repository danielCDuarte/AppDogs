//
//  DogCellView.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import SkeletonUI
import SwiftUI

struct DogCellView: View {
    
    var dogObject: DogObject?
    var loading: Bool
    
    init(dogObject: DogObject?,
         loading: Bool) {
        self.dogObject = dogObject
        self.loading = loading
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            AsyncImage(url: URL.getUrl(from: dogObject?.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 180)
                    .clipped()
            } placeholder: {
                AnyView(ActivityIndicator())
                    .frame(width: 120, height: 180)
            }
            .skeleton(with: loading)
            .cornerRadius(10)
            VStack(alignment: .leading) {
                Spacer(minLength: 30)
                VStack(alignment: .leading, spacing: 10) {
                    Text(dogObject?.name ?? "")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .skeleton(with: loading)
                    
                    Text(dogObject?.desc ?? "")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .skeleton(with: loading)
                    Text("Almost \(String(dogObject?.age ?? 0)) years")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .skeleton(with: loading)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                .background(Color.white)
                .cornerRadius(10, corners: [.topRight, .bottomRight])
            }
        }
    }
}

#Preview {
    DogCellView(
        dogObject:
                .init(
                    id: UUID(),
                    name: "Rex",
                    desc: "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot",
                    age: 5,
                    image: "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
                ),
        loading: false)
    .frame(height: 180)
}
