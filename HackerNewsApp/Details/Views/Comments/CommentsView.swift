//
//  CommentsView.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 12/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class CommentsView: UIView {

    // comment table
    @IBOutlet weak var tableView: UITableView!
    
    // creating instance of view
    class func instanceFromNib() -> UIView {
         return UINib(nibName:"CommentsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
     }

}
