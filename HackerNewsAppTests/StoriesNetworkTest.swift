//
//  NetworkTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class StoriesNetworkTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testNetworkTopStoriesIds() {
        let network = Network()
        let expectation = XCTestExpectation(description: "Download Up to 500 top and new stories")
        network.getTopStoriesIds { (stories) in
            XCTAssertNotNil(stories,"Failed to download stories")
            XCTAssertTrue(stories?.count == 500,"Failed to download 500 stories")
            
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
       
    }
    
    func testNetworkTopStoriesItems() {
        let network = Network()
        let expectation = XCTestExpectation(description: "Download Up to 25 top and new stories")
        network.getTopStoriesInDetails { (stories) in
            
            XCTAssertNotNil(stories,"Failed to download stories details")

            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 10.0)
       
    }
}
