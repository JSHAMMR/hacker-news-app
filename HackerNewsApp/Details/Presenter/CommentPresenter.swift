//
//  CommentPresenter.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

protocol CommentPresenterDelegate : AnyObject {
    func didFetchCommentItems(success:Bool)
}

class CommentPresenter: NSObject {
    weak var delegate: CommentPresenterDelegate? // to feed provider/uis with data
    let commentViewModel: CommentViewModel! // viewmodel instance
    
    var commentItems:[Comment] = [Comment]()

    init(commentViewModel: CommentViewModel) { // init func
        self.commentViewModel = commentViewModel
        super.init()
        self.commentViewModel.delegate = self
    }
    
    public func fetchCommentItems (commentIds:[Int]) { // calling the vm to get the data
        self.commentViewModel.fetchCommentItems(commentIds: commentIds)
    }
    
    public func getCommentCount() -> Int { // get comment count
        return self.commentItems.count
    }
    public func getComment(index:Int) -> Comment {
        return self.commentItems[index] // get specifc commment using index
    }
  
}

extension CommentPresenter:CommentListModelDelegate {
    func didFetchCommentItems(success: Bool, commentItems: [Comment]) {
        self.commentItems = commentItems // feeding the provider with this data
        if let delegate = self.delegate {
            delegate.didFetchCommentItems(success: success)// update protocol
            return
        }
    }
    
    
}
