//
//  CommentListProvider.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
protocol CommentListProviderProtocol {
    func didSelectCell(story: Story)
}
class CommentListProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    var commentListProviderProtocol: CommentListProviderProtocol?
    var commentPresenter:CommentPresenter!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentPresenter.getCommentCount()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell

        cell.comment = self.commentPresenter.getComment(index: indexPath.row)
        
        return UITableViewCell()
    }
    

}
