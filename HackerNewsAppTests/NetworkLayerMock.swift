//
//  NetworkLayerMock.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
import HackerNewsApp

class NetworkLayerMock: Network {

    private var mockedStoies: [Story]!
    private var mockedStoiesIds: Stories!

    
    init(mockedStories:[Story]) {
        self.mockedStoies = mockedStories
    }
    init(mockedStoriesIds:Stories) {
        self.mockedStoiesIds = mockedStoriesIds
    }
    
    override func getTopStoriesInDetails(completion: @escaping ([Story]?) -> Void) {
        completion(self.mockedStoies)
    }
    
    override func getTopStoriesIds(completion: @escaping (Stories?) -> Void) {
        completion(self.mockedStoiesIds)
    }

}
