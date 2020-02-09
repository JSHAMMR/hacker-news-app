//
//  CommentEndToEndTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
@testable import HackerNewsApp

class CommentEndToEndTestDelegate: CommentListProviderProtocol {
    func didSelectCell(comment: Comment) {
        didSelectCell = true
        self.comment = comment
    }

    var didSelectCell: Bool = false
    var comment: Comment?
}
class CommentEndToEndTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommentEndToEnd() {
        let comment1 = Comment(by: "pg", id: 121016, kids: [121349,121108,121303,121154], parent: 121003, text: "You can see two spikes in unique visitors due to Arc here:<p><a href=\"http://ycombinator.com/images/news.yc.1year.png\" rel=\"nofollow\">http://ycombinator.com/images/news.yc.1year.png</a><p>There was a spike in Jan when I said Arc was imminent, and then another when it came out.  But if you squint your eyes and look at the whole curve, the underlying growth rate seems pretty constant.<p>In other words, while it's true we've been getting a lot of new users lately, this probably would have happened anyway.<p>What to do about that growth is another matter.  I think a lot of users are alarmed at the sight of fluff links on the front page because they remember what that meant for other sites in the past.  But the current fluff link (<a href=\"http://news.ycombinator.com/item?id=120816\" rel=\"nofollow\">http://news.ycombinator.com/item?id=120816</a>) was submitted by a long-time user, and there are no signs of statistical weirdness in the votes on it.  I.e. statistically the users who upvoted that story are no different from the ones upvoting the other top stories.  So at the moment I'm still hopeful that the bad signs are false alarms.<p>I have a hunch that the way to fend off the hordes of 14 year olds is to keep up the quality of the stories on the front page.  Then if they come across this site they'll decide it's boring and leave.", time: 1203648734, type: "comment")

        let comment2 = Comment(by: "yters", id: 121109, kids: [122396,121134], parent: 121003, text: "Does having 3 main hacker sites (this, proggit, /.) imply the retreat from 14 year olds will reach a stable equilibrium, and end the eternal September problem?\n<a href=\"http://en.wikipedia.org/wiki/Eternal_September\" rel=\"nofollow\">http://en.wikipedia.org/wiki/Eternal_September</a><p>There are only so many 14 year olds in the world, so at some point the rate of change in users will be 0, incoming equals outgoing.", time: 1203661550, type: "comment")



        let comments : [Comment] = [comment1, comment2]

        let networkLayer = NetworkLayerMock(mockedComments: comments)
        let commentViewModel = CommentViewModel(networkLayer: networkLayer)
        let commentPresenter = CommentPresenter(commentViewModel: commentViewModel)

        commentPresenter.fetchCommentItems(commentIds: [121016, 121109])


        let commentProvider = CommentListProvider()
        commentProvider.commentPresenter = commentPresenter


        let tableView = UITableView()
        let commentEndToEndTestDelegate = CommentEndToEndTestDelegate()

        tableView.register(CommentTableViewCell.self,
        forCellReuseIdentifier: "CommentTableViewCell")

        tableView.dataSource = commentProvider
        tableView.delegate = commentProvider
        commentProvider.commentListProviderProtocol = commentEndToEndTestDelegate


        XCTAssertEqual(commentProvider.tableView(tableView, numberOfRowsInSection: 1), 2,"Number of comments rows not correct")
        XCTAssertEqual(commentProvider.numberOfSections(in: tableView), 1,"Number of comments sections not correct")

        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertFalse(commentEndToEndTestDelegate.didSelectCell)

        let indexPath2 = IndexPath(row: 1, section: 0)
        commentProvider.tableView(tableView, didSelectRowAt: indexPath2)
        XCTAssertTrue(commentEndToEndTestDelegate.didSelectCell)



        let comment = commentEndToEndTestDelegate.comment

        XCTAssertTrue(comment!.by == "yters", "failed to get first comment auther")
        XCTAssertEqual(comment!.time, 1203661550, "failed to get second comment time")
        XCTAssertEqual(comment!.parent, 121003, "failed to get second comment parent")
        XCTAssertEqual(comment!.kids, [122396,121134], "failed to get first comment childs")

        
    }
    
    

}