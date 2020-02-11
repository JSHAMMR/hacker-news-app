//
//  NetworkLayerMock.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
import HackerNewsApp

class NetworkLayerMock: Network { // inheret from network layer

    private var mockedStories: [Story]!
    private var mockedStoiesIds: Stories!
    private var mockedComments: [Comment]!

    // getting  mockedStories
    init(mockedStories:[Story]) {
        self.mockedStories = mockedStories
    }
    // getting  mockedStoriesIds
    init(mockedStoriesIds:Stories) {
        self.mockedStoiesIds = mockedStoriesIds
    }
    // getting  mockedComments
    init(mockedComments:[Comment]) {
        self.mockedComments = mockedComments
    }
    // getting  mocked TopStoriesInDetails
    override func getTopStoriesInDetails(completion: @escaping ([Story]?) -> Void) {
        completion(self.mockedStories)
    }
    // getting  mocked TopStoriesIds
    override func getTopStoriesIds(completion: @escaping (Stories?) -> Void) {
        completion(self.mockedStoiesIds)
    }
    // getting  mocked Comments
    override func getComments(commentIds: [Int], completion: @escaping ([Comment]?) -> Void) {
        completion(self.mockedComments)
    }
    

}
