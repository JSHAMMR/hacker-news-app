//
//  StoriesModelDecoderTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class StoriesModelDecoderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // testing decoder from mock json (Stories model)

    func testStoryIdsDecoder() {
        let storyJSON = [
        22272966,
        22272844,
        22269115,
        22263022]
        
        
        do {
            
            
            let jsonData = try JSONSerialization.data(withJSONObject: storyJSON, options: [])
            let stories : Stories = try! Stories(data: jsonData)
            
            XCTAssertTrue(stories.count == 4, "Failed to return the expected count of stories")
            XCTAssertEqual(stories.first,22272966 , "Failed to return the expected id of story")
            XCTAssertEqual(stories.last,22263022 , "Failed to return the expected id of story")

            
        } catch let error {
            print(error)
        }

    }
    
    // testing decoder from mock json (Story model)

    func testStoryItemDecoder() {
        let storyJSON =
        ["by": "tel",
        "descendants": 16,
        "id": 121003,
        "kids": [
        121016,
        121109,
        121168
        ],
        "score": 25,
        "text": "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
        "time": 1203647620,
        "title": "Ask HN: The Arc Effect",
        "type": "story"
            ] as [String : Any]
   
        
        
        do {
            
            
            let jsonData = try JSONSerialization.data(withJSONObject: storyJSON, options: [])
            let story : Story = try! Story(data: jsonData)
            
            XCTAssertTrue(story.kids?.count == 3, "Failed to return the expected count of childs")
            XCTAssertEqual(story.by, "tel", "Failed to return the expected story auther")
            XCTAssertEqual(story.id, 121003, "Failed to return the expected story id")
            XCTAssertEqual(story.time, 1203647620, "Failed to return the expected story time")

            
        } catch let error {
            print(error)
        }
        
        
        
        
    }

}
