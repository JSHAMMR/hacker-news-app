//
//  StoriesEndToEndTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class StoriesEndToEndTestDelegate: StoriesListProviderProtocol {
    func didSelectCell(story: Story) {
        didSelectCell = true
        self.story = story
    }
    
    
    var didSelectCell: Bool = false
    var story: Story?
    
    
}

class StoriesEndToEndTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testStoriesEndToEnd() {
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
        storiesPresenter.fetchStoriesItems()

        let storiesListProvider = StoriesListProvider()

        storiesListProvider.storiesPresenter = storiesPresenter

        let tableView = UITableView()
        let storiesEndToEndTestDelegate = StoriesEndToEndTestDelegate()

        tableView.register(StoryTableViewCell.self,
        forCellReuseIdentifier: "StoryTableViewCell")

        tableView.dataSource = storiesListProvider
        tableView.delegate = storiesListProvider
        storiesListProvider.storiesListProviderProtocol = storiesEndToEndTestDelegate


        XCTAssertEqual(storiesListProvider.tableView(tableView, numberOfRowsInSection: 1), 2,"Number of stories rows not correct")
        XCTAssertEqual(storiesListProvider.numberOfSections(in: tableView), 1,"Number of stories sections not correct")

        
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertFalse(storiesEndToEndTestDelegate.didSelectCell)
        
        let indexPath2 = IndexPath(row: 1, section: 0)
        storiesListProvider.tableView(tableView, didSelectRowAt: indexPath2)
        XCTAssertTrue(storiesEndToEndTestDelegate.didSelectCell)
        
        

         let story = storiesEndToEndTestDelegate.story
        
        XCTAssertTrue(story!.by == "sev", "failed to get first story auther")
        XCTAssertEqual(story!.descendants, 178, "failed to get second story descendants")
        XCTAssertEqual(story!.score, 234, "failed to get second story descendants")
        XCTAssertEqual(story!.kids, [22269967,22269989], "failed to get first story childs")

    }


}
