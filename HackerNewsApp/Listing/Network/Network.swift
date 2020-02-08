//
//  Network.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

open class Network: NSObject {
    func getTopStories(api:String, completion:@escaping (Data?) -> Void)  {

        guard let getUrl = URL(string: hackerNewsAPIBaseUrL + topStoriesAction) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: getUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let returnData = String(data: data, encoding: .utf8) {
                    print(returnData)
                } else {
                    print("empty")
                }
            }
            
            if let err = error {
                print("Err", err)
            }
            
            completion(data)
        }
        dataTask.resume()
    }
    
    
    
    
    
    
    
    
}
