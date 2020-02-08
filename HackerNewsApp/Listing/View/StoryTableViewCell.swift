//
//  StoryTableViewCell.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subtitleLbl: UILabel!
    @IBOutlet var urlLbl: UILabel!
    @IBOutlet var scoreLbl: UILabel!
    @IBOutlet var commentButton: UIButton!

    var story:Story!{
        didSet {
            titleLbl.text = story.title ?? ""
            subtitleLbl.text = "\(story.score ?? 0) Points by \(story.by ?? "") - \(story.kids?.count ?? 0) comments - \(Date().getElapsedInterval(unixTimestamp: story.time ?? 0))"
            
            urlLbl.text = story.url ?? ""
            scoreLbl.text = "\(story.score ?? 0)"
            commentButton.setTitle("\(story.kids?.count ?? 0)", for: .normal)
            
        }
    }
}
