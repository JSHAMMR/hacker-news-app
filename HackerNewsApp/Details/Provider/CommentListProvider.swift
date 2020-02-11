//
//  CommentListProvider.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
protocol CommentListProviderProtocol {
    func didSelectCell(comment: Comment)
}
class CommentListProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var commentListProviderProtocol: CommentListProviderProtocol? //  to update testing cell
    var commentPresenter:CommentPresenter! // feed provider then pass to ui

    var comments = [Comment]()
    let network = Network()

    let colors : [UIColor] = [UIColor(named: "level1")!,UIColor(named: "level2")!,UIColor(named: "level3")!,UIColor(named: "level4")!,UIColor(named: "level5")!] //  between levels
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment: Comment = self.comments[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.comment = comment
        cell.backgroundColor = self.colors[self.checklevel(level: 0, comment: comment) <= 4 ? self.checklevel(level: 0, comment: comment) : 0] // change cell color based on level
        
//        print("level : \(self.checklevel(level: 0, comment: comment) * 20)")


        return cell
    }
    
    // put the child after thier parent and do shift for the rest
    func shiftAppend(index:Int, comments:[Comment]) {
        var currentIndex = index
        let shift = self.comments.count - 1
        let shiftedList = self.comments[index...shift]
        comments.forEach({ (aComment) in
            currentIndex = currentIndex + 1
            self.comments.insert(aComment, at: currentIndex)
        })
     
//        print(shiftedList)
    }
    // getting the level recursevly (inifint levels)
    func checklevel(level:Int, comment:Comment) -> Int {
        
        let levelComment = self.comments.filter{comment.parent == $0.id}
        if levelComment.count == 0 {
            return level

        }
        
        return checklevel(level: level + 1, comment: levelComment[0])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let comment: Comment = self.comments[indexPath.row]
        commentListProviderProtocol?.didSelectCell(comment: comment)

        print(self.checklevel(level: 0, comment: comment))
        
        if comment.kids != nil { // check the validation
            if comment.kids!.count > 0 {// check the parent has kids

            let sortId = self.comments.filter { $0.id ==  comment.kids![0]} // filter if this prent already got his kids

                if sortId.count == 0 { // mean he did get kids so far
                    network.getComments(commentIds: comment.kids!) { (comments) in // bring only his kids

                self.shiftAppend(index: indexPath.row, comments: comments!) // do shifing
                tableView.reloadData() // update ui
            }
                }
                
            }
        }
       }

}
