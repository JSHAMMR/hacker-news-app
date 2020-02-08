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
    
    
    init(mockedStories:[Story]) {
        self.mockedStoies = mockedStories
    }
    
    override func getTopStoriesInDetails(completion: @escaping ([Story]?) -> Void) {
        completion(self.mockedStoies)
    }

}
