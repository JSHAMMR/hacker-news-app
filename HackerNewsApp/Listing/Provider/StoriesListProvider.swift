//
//  StoriesListProvider.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
protocol StoriesListProviderProtocol {
    func didSelectCell(story: Story)
}
class StoriesListProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    var storiesListProviderProtocol: StoriesListProviderProtocol?

    var storiesPresenter:StoriesPresenter!
    var parentViewController:StoriesListViewController!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesPresenter.getStoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as! StoryTableViewCell
        
        let story: Story = storiesPresenter.getStory(index: indexPath.row)
        cell.story = story
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story: Story = storiesPresenter.getStory(index: indexPath.row)
        storiesListProviderProtocol?.didSelectCell(story: story)
        
        let storyboard = UIStoryboard(name: StoryboardID.main, bundle: nil)
        
        
        if parentViewController != nil {
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                  detailViewController?.story = story
              parentViewController.navigationController?.pushViewController(detailViewController!, animated: true)
                 
        }
       
        
    }
    
    

}
