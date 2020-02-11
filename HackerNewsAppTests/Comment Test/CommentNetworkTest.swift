//
//  CommentNetworkTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class CommentNetworkTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    // testing real network call for testNetworkGetComment
    func testNetworkGetComment() {
        let network = Network()
        let expectation = XCTestExpectation(description: "Download Up to 25 top and new stories")

        network.getComments(commentIds:[121016,121109,121168]) { (comments) in
            XCTAssertNotNil(comments,"Failed to download comments ")
            XCTAssertFalse(comments?.count == 0,"comments count is zero")
            XCTAssertTrue(comments?.count == 3,"Failed to load all comments")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)

    }

}
