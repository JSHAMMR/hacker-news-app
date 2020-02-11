//
//  StoriesPresenter.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

protocol StoriesPresenterDelegate : AnyObject { // to update proivers /uis
    func didFetchStoriesItems(success:Bool)
    func didFetchAllStoriesIds(success:Bool)
}
extension StoriesPresenterDelegate { // getting all stries ids only (api prespective)
    func didFetchAllStoriesIds(success:Bool) {
        
    }
}

class StoriesPresenter: NSObject {
    weak var delegate: StoriesPresenterDelegate?
    private let storiesViewModel: StoriesViewModel!// getting view model
    
    fileprivate var storiesItems:[Story] = [Story]()
    fileprivate var storiesIds:Stories = [Int]()

    init(storiesViewModel:StoriesViewModel) { // init view mode
        self.storiesViewModel = storiesViewModel
        super.init()
        self.storiesViewModel.delegate = self
    }
    
    public func fetchStoriesItems () { // asking view model to get stroies details
        self.storiesViewModel.fetchStoriesItems()
    }
    
    public func fetchStoriesIds () {// asking view model to get stroies ids
        self.storiesViewModel.fetchStorisIds()
    }
    
    public func getStory (index:Int) -> Story { // get sepefic story using index
        return self.storiesItems[index]
    }
    public func getStoryCount () -> Int { // get stories count
        return self.storiesItems.count
    }
    public func getStoriesIds () -> Stories { // get stories ids
        return self.storiesIds
    }
    
}
extension StoriesPresenter : StoriesListModelDelegate {
    
    func didFetchStoriesItems(success: Bool, storiesItems: [Story]) { // update proivder/uis by stories details
        self.storiesItems = storiesItems
        if let delegate = self.delegate {
            delegate.didFetchStoriesItems(success: success)
            return
        }
    }
    
    func didFetchAllStoriesIds(success: Bool, storiesIds: Stories) {// update proivder/uis by stories ids
        self.storiesIds = storiesIds
        if let delegate = self.delegate {
            delegate.didFetchAllStoriesIds(success: success)
            return
        }
    }
    
    
}
