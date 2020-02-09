//
//  CommentsModelDecoderTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class CommentsModelDecoderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommentItemDecoder() {
         let commentJSON =
         ["by": "pg",
         "id": 121016,
         "kids": [
         121349,
         121108,
         121303,
         121154
         ],
         "parent": 121003,
         "text": "You can see two spikes in unique visitors due to Arc here:<p><a href=\"http://ycombinator.com/images/news.yc.1year.png\" rel=\"nofollow\">http://ycombinator.com/images/news.yc.1year.png</a><p>There was a spike in Jan when I said Arc was imminent, and then another when it came out.  But if you squint your eyes and look at the whole curve, the underlying growth rate seems pretty constant.<p>In other words, while it's true we've been getting a lot of new users lately, this probably would have happened anyway.<p>What to do about that growth is another matter.  I think a lot of users are alarmed at the sight of fluff links on the front page because they remember what that meant for other sites in the past.  But the current fluff link (<a href=\"http://news.ycombinator.com/item?id=120816\" rel=\"nofollow\">http://news.ycombinator.com/item?id=120816</a>) was submitted by a long-time user, and there are no signs of statistical weirdness in the votes on it.  I.e. statistically the users who upvoted that story are no different from the ones upvoting the other top stories.  So at the moment I'm still hopeful that the bad signs are false alarms.<p>I have a hunch that the way to fend off the hordes of 14 year olds is to keep up the quality of the stories on the front page.  Then if they come across this site they'll decide it's boring and leave.",
         "time": 1203648734,
         "type": "comment"
             ] as [String : Any]
    
         
         
         do {
             
             
             let jsonData = try JSONSerialization.data(withJSONObject: commentJSON, options: [])
             let comment : Comment = try! Comment(data: jsonData)
             
             XCTAssertTrue(comment.kids?.count == 4, "Failed to return the expected count of childs")
             XCTAssertEqual(comment.by, "pg", "Failed to return the expected comment auther")
             XCTAssertEqual(comment.id, 121016, "Failed to return the expected comment id")
             XCTAssertEqual(comment.time, 1203648734, "Failed to return the expected comment time")

             
         } catch let error {
             print(error)
         }
         
         
         
         
     }


}
