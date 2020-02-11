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
    var commentListProviderProtocol: CommentListProviderProtocol?
    var commentPresenter:CommentPresenter!

    var comments = [Comment]()
    let network = Network()

    let colors : [UIColor] = [UIColor(named: "level1")!,UIColor(named: "level2")!,UIColor(named: "level3")!]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment: Comment = self.comments[indexPath.row]

    {
             let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.comment = comment
        cell.backgroundColor = self.colors[self.checklevel(level: 0, comment: comment)]
        
        print("level : \(self.checklevel(level: 0, comment: comment) * 20)")


        return cell
    }
    
    func shiftAppend(index:Int, comments:[Comment]) {
        var currentIndex = index
        let shift = self.comments.count - 1
        let shiftedList = self.comments[index...shift]
        comments.forEach({ (aComment) in
            currentIndex = currentIndex + 1
            self.comments.insert(aComment, at: currentIndex)
        })
     
        print(shiftedList)
    }
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
        
        if comment.kids != nil {
            if comment.kids!.count > 0 {

            let sortId = self.comments.filter { $0.id ==  comment.kids![0]}

                if sortId.count == 0 {
                    network.getComments(commentIds: comment.kids!) { (comments) in

                self.shiftAppend(index: indexPath.row, comments: comments!)
                tableView.reloadData()
            }
                }
                
            }
        }
       }

}
