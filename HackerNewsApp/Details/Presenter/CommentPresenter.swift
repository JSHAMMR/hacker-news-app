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
    weak var delegate: CommentPresenterDelegate?
    private let commentViewModel: CommentViewModel!
    
    fileprivate var commentItems:[Comment] = [Comment]()
    
    init(commentViewModel: CommentViewModel) {
        self.commentViewModel = commentViewModel
        super.init()
        self.commentViewModel.delegate = self
    }
    
    public func fetchCommentItems (commentIds:[Int]) {
        self.commentViewModel.fetchCommentItems(commentIds: commentIds)
    }
    
    public func getCommentCount() -> Int {
        return self.commentItems.count
    }
    
  
}

extension CommentPresenter:CommentListModelDelegate {
    func didFetchCommentItems(success: Bool, commentItems: [Comment]) {
        self.commentItems = commentItems
        if let delegate = self.delegate {
            delegate.didFetchCommentItems(success: success)
            return
        }
    }
    
    
}
