//
//  StoriesIntegrationTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class StoriesListMock: NSObject, StoriesPresenterDelegate {
    func didFetchStoriesItems(success: Bool) {
        storiesItems = success
    }
    
    func didFetchAllStoriesIds(success: Bool) {
        storiesIds = success

    }
    

    var storiesItems = false
    var storiesIds = false

}


class StoriesIntegrationTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // testing  network->view model-> presenter-> Controller delegate for StoriesIds

    func testShowStoriesIds() {
            let stories : Stories =
                [22272966,
                22272844,
                22269115,
                22263022,
                22266173,
                22272233,
                22254719]

            let networkLayer = NetworkLayerMock(mockedStoriesIds:stories)
            let storiesViewModel = StoriesViewModel(networkLayer: networkLayer)
            let storiesPresenter = StoriesPresenter(storiesViewModel: storiesViewModel)

            let storiesListMock = StoriesListMock()

            storiesPresenter.delegate = storiesListMock
            storiesPresenter.fetchStoriesIds()

            XCTAssertTrue(storiesListMock.storiesIds, "Success in fetching stories")

            let firstStoryId = storiesPresenter.getStoriesIds().first
            let lastStoryId = storiesPresenter.getStoriesIds().last

            XCTAssertEqual(firstStoryId, 22272966, "failed to get first story Id")
            XCTAssertEqual(lastStoryId, 22254719, "failed to get last story Id")


       }
    // testing  network->view model-> presenter-> Controller delegate for StoryAttributes

    func testShowStoryAttributes() {
        let story1 =
            Story(by: "tel",
            descendants: 16,
            id: 121003,
            kids:  [121016,121109,121168]
            , score: 25,
            text: "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
            time: 1203647620, title: "Ask HN: The Arc Effect", type: "story", url: nil)

        let story2 =
            Story(by: "sev",
            descendants: 178,
            id: 22269762,
            kids:  [22269967,22269989]
            , score: 234,
            text: nil,
            time: 1581103591, title: "ThinkPad T480 is my new main laptop which runs FreeBSD", type: "story", url: nil)


        let stories : [Story] = [story1, story2]
        let networkLayer = NetworkLayerMock(mockedStories: stories)
        let storiesViewModel = StoriesViewModel(networkLayer: networkLayer)
        let storiesPresenter = StoriesPresenter(storiesViewModel: storiesViewModel)

        let storiesListMock = StoriesListMock()

        storiesPresenter.delegate = storiesListMock
        storiesPresenter.fetchStoriesItems()

        let firstStory = storiesPresenter.getStory(index: 0)
        let secondStory = storiesPresenter.getStory(index: 1)
              
        
        XCTAssertTrue(storiesListMock.storiesItems, "Failed in fetching stories")
        // Asserting on stories values
        XCTAssertTrue(firstStory.by == "tel", "failed to get first story auther")
        XCTAssertTrue(secondStory.by == "sev", "failed to get first story auther")

        XCTAssertEqual(firstStory.descendants, 16, "failed to get first story descendants")
        XCTAssertEqual(secondStory.descendants, 178, "failed to get second story descendants")

        XCTAssertEqual(firstStory.score, 25, "failed to get first story descendants")
        XCTAssertEqual(secondStory.score, 234, "failed to get second story descendants")

        XCTAssertEqual(firstStory.kids, [121016,121109,121168], "failed to get first story childs")
        XCTAssertEqual(secondStory.kids, [22269967,22269989], "failed to get first story childs")


    }
    
    
}
