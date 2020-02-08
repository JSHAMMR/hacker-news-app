//
//  Network.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

open class Network: NSObject {
    
    // getting the ids of top stories as api schema has
    func getTopStories( completion:@escaping (Data?) -> Void)  {

        guard let getUrl = URL(string: hackerNewsAPIBaseUrL + topStoriesAction) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: getUrl) { (data, response, error) in
            guard let data = data else { return }
            if let err = error {
                print("Err", err)
            }
            
            completion(data)
        }
        dataTask.resume()
    }
    
    
    // getting each story item attributes
    open func getTopStoriesInDetails( completion:@escaping ([Story]?) -> Void) {
        
        let dispatchGroup = DispatchGroup()// for asynchronous process
        var storiesDetailsList = [Story]()

        getTopStories { (storiesData) in
            do {
                
                let allTopStoriesIds = try Stories(data: storiesData!)
                // take only first 25 ids
                let topStoriesIds = allTopStoriesIds[0..<24]

                
                topStoriesIds.forEach { (storyID) in
                    let storyUrl = URL(string:hackerNewsAPIBaseUrL+"item/"+"\(storyID)"+".json?print=pretty") // url request for each item
                    dispatchGroup.enter() // starting the call
                    URLSession.shared.dataTask(with: storyUrl!) { data, response, error in
                        
                         do {
                             let story = try Story(data: data!)
                            storiesDetailsList.append(story) //
                               } catch let error {
                                   print(error)
                               }
                         dispatchGroup.leave() // leave when the task is done
                     }.resume()

                }
                
                // complete the process
                dispatchGroup.notify(queue: DispatchQueue.main) {
                       completion(storiesDetailsList)
                   }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    
    
    
}
