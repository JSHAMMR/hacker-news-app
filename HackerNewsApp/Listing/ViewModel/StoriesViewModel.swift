//
//  StoriesViewModel.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

protocol StoriesListModelDelegate : AnyObject {
    func didFetchStoriesItems(success:Bool, storiesItems:[Story])
}
open class StoriesViewModel: NSObject {
       weak var delegate: StoriesListModelDelegate?
    
    
       private let networkLayer: Network

       init(networkLayer:Network) {
           self.networkLayer = networkLayer
       }
    
    open func fetchStoriesItems() {
           
        
        self.networkLayer.getTopStoriesInDetails { (stories) in
            if let delegate = self.delegate {
                  delegate.didFetchStoriesItems(success: true, storiesItems: stories!)
                  return
              }
            
            if let delegate = self.delegate {
                delegate.didFetchStoriesItems(success: false, storiesItems: stories!)
                return
            }
        }
           
       }
}