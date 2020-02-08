//
//  StoriesPresenter.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

protocol StoriesPresenterDelegate : AnyObject {
    func didFetchStoriesItems(success:Bool)
    func didFetchAllStoriesIds(success:Bool)
}

class StoriesPresenter: NSObject {
    weak var delegate: StoriesPresenterDelegate?
    private let storiesViewModel: StoriesViewModel!
    
    fileprivate var storiesItems:[Story]!
    fileprivate var storiesIds:Stories!

    init(storiesViewModel:StoriesViewModel) {
        self.storiesViewModel = storiesViewModel
        super.init()
        self.storiesViewModel.delegate = self
    }
    
    public func fetchStoriesItems () {
        self.storiesViewModel.fetchStoriesItems()
    }
    
    public func fetchStoriesIds () {
        self.storiesViewModel.fetchStorisIds()
    }
    
    public func getStory (index:Int) -> Story {
        return self.storiesItems[index]
    }
    
    public func getStoriesIds () -> Stories {
        return self.storiesIds
    }
    
}
extension StoriesPresenter : StoriesListModelDelegate {
    
    func didFetchStoriesItems(success: Bool, storiesItems: [Story]) {
        self.storiesItems = storiesItems
        if let delegate = self.delegate {
            delegate.didFetchStoriesItems(success: success)
            return
        }
    }
    
    func didFetchAllStoriesIds(success: Bool, storiesIds: Stories) {
        self.storiesIds = storiesIds
        if let delegate = self.delegate {
            delegate.didFetchAllStoriesIds(success: success)
            return
        }
    }
    
    
}
