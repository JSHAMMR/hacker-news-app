//
//  CommentTableViewCell.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var autherLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var textLbl: UILabel!

    var comment:Comment! {
        didSet{
            autherLbl.text = comment.by ?? ""
            timeLbl.text = "\(Date().getElapsedInterval(unixTimestamp: comment.time ?? 0) )"
            textLbl.text = comment.text ?? ""

        }
    }
}
