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

    private var mockedStories: [Story]!
    private var mockedStoiesIds: Stories!
    private var mockedComments: [Comment]!

    
    init(mockedStories:[Story]) {
        self.mockedStories = mockedStories
    }
    init(mockedStoriesIds:Stories) {
        self.mockedStoiesIds = mockedStoriesIds
    }
    init(mockedComments:[Comment]) {
        self.mockedComments = mockedComments
    }
    override func getTopStoriesInDetails(completion: @escaping ([Story]?) -> Void) {
        completion(self.mockedStories)
    }
    
    override func getTopStoriesIds(completion: @escaping (Stories?) -> Void) {
        completion(self.mockedStoiesIds)
    }
    
    override func getComments(commentIds: [Int], completion: @escaping ([Comment]?) -> Void) {
        completion(self.mockedComments)
    }
    

}
