//
//  StoriesListProvider.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class StoriesListProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var storiesPresenter:StoriesPresenter!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesPresenter.getStoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as! StoryTableViewCell
        
        cell.story = storiesPresenter.getStory(index: indexPath.row)
        return cell
        
    }
    
    
    

}
