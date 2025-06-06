//
//  TestDataConstants.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
@testable import AppDogs

struct TestDataConstants {
    static let dogsResponse: [APIDogResponse] = {
        return [
            .init(
                name: "Rex",
                description: "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot",
                age: 5,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
            ),
            .init(
                name: "Spots",
                description: "Is the brother of Chief and are also a former guard dog for Mayor Kobayashi's ward",
                age: 3,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/6/6b/Spots.jpg/revision/latest/scale-to-width-down/666?cb=20180624191101"
            ),
            .init(
                name: "Chief",
                description: "He is a leader of a pack of dogs",
                age: 8,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/1/1d/Chief-0.jpg/revision/latest/scale-to-width-down/666?cb=20180624184431"
            )
        ]
    }()
    
    static let dogsModel: [DogModel] = {
        return [
            .init(
                name: "Rex",
                desc: "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot",
                age: 5,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
            ),
            .init(
                name: "Spots",
                desc: "Is the brother of Chief and are also a former guard dog for Mayor Kobayashi's ward",
                age: 3,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/6/6b/Spots.jpg/revision/latest/scale-to-width-down/666?cb=20180624191101"
            ),
            .init(
                name: "Chief",
                desc: "He is a leader of a pack of dogs",
                age: 8,
                image: "https://static.wikia.nocookie.net/isle-of-dogs/images/1/1d/Chief-0.jpg/revision/latest/scale-to-width-down/666?cb=20180624184431"
            )
        ]
    }()
    
    static let dogModel: DogModel = {
        return .init(
            name: "Rex",
            desc: "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot",
            age: 5,
            image: "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
        )
    }()
}
