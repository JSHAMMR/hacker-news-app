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
    open func getTopStoriesIds( completion:@escaping (Stories?) -> Void)  {

        guard let getUrl = URL(string: hackerNewsAPIBaseUrL + topStoriesAction) else { return }
 
        URLSession.shared.dataTask(with: getUrl) { data, response, error in
            var stories:Stories!
                do {
                    stories = try Stories(data: data!)
                } catch let error {
                    print(error)
                }
            
            completion(stories)
            
            }.resume()
    }
    
    
    // getting each story item attributes
    open func getTopStoriesInDetails( completion:@escaping ([Story]?) -> Void) {
        
        let dispatchGroup = DispatchGroup()// for asynchronous process
        var storiesDetailsList = [Story]()

        getTopStoriesIds { (stories) in
                // take only first 25 ids - reduce fetching items
                let topStoriesIds = stories![0..<25]

                
                topStoriesIds.forEach { (storyID) in
                    let storyUrl = URL(string:hackerNewsAPIBaseUrL+"item/"+"\(storyID)"+".json?print=pretty") // url request for each item
                    dispatchGroup.enter() // starting the asynchronous process for one item
                    print("requesting story id\(storyID) ....")
                    URLSession.shared.dataTask(with: storyUrl!) { data, response, error in
                        
                        do {
                            let story = try Story(data: data!)
                            storiesDetailsList.append(story) //
                        } catch let error {
                            print(error)
                        }
                            print("requested story id\(storyID) ....")
                            dispatchGroup.leave() // leave when the task is done
                     }.resume()

                }
                
                // complete the process
                dispatchGroup.notify(queue: DispatchQueue.main) {
                       completion(storiesDetailsList)
                   }
                
           
        }
    }
    
    
    open func getComments(commentIds:[Int], completion:@escaping ([Comment]?) -> Void) {
     
        let dispatchGroup = DispatchGroup()// for asynchronous process
        var commentList = [Comment]()

        commentIds.forEach { (commentId) in
            let commentUrl = URL(string:hackerNewsAPIBaseUrL+"item/"+"\(commentId)"+".json?print=pretty") // url request for each item
            dispatchGroup.enter() // starting the asynchronous process for one item
            print("requesting story id\(commentId) ....")
            URLSession.shared.dataTask(with: commentUrl!) { data, response, error in

            do {
                let comment = try Comment(data: data!)
                commentList.append(comment) //
            } catch let error {
                print(error)
            }
            print("requested story id\(commentId) ....")
            dispatchGroup.leave() // leave when the task is done
            }.resume()

        }
        // complete the process
         dispatchGroup.notify(queue: DispatchQueue.main) {
                completion(commentList)
            }
        
        
    }
    
    
    
}
