//
//  CommentViewModel.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
protocol CommentListModelDelegate : AnyObject {
    func didFetchCommentItems(success:Bool, commentItems:[Comment])

}
class CommentViewModel: NSObject {
    weak var delegate: CommentListModelDelegate? // to feed presenter

    private let networkLayer: Network
    init(networkLayer:Network) { // connect network layer
        self.networkLayer = networkLayer
    }
    
    open func fetchCommentItems(commentIds:[Int]) { // fetching the comments delegate to update presenter status
           
        self.networkLayer.getComments(commentIds: commentIds) { (comments) in
            if let delegate = self.delegate {
                delegate.didFetchCommentItems(success: true, commentItems: comments!)
                  return
              }
            
            if let delegate = self.delegate {
                delegate.didFetchCommentItems(success: false, commentItems: comments!)
                return
            }
        }
           
       }
}
