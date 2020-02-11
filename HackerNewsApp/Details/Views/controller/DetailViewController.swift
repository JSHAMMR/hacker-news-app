//
//  DetailViewController.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var commentTab: UIButton!
    @IBOutlet weak var webTab: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var story:Story!
    fileprivate var webDetail:WebDetail!
    fileprivate var commentsView:CommentsView!
    var commentPresenter:CommentPresenter!
    @IBOutlet var commentListProvider: CommentListProvider!
       
      
    override func viewDidLoad() {
        super.viewDidLoad()

        self.highlight(view: self.commentTab, state: false)
        self.highlight(view: self.webTab, state: true)
        // Do any additional setup after loading the view.
        //
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        // add webview to scrollview
        self.addCommentsView()
        self.addWebViewDetail()

        scrollView.contentSize = CGSize(width: self.webDetail.frame.size.width + self.commentsView.frame.size.width, height: self.view.frame.height )
        
        
        /////
        // Do any additional setup after loading the view.
        self.commentPresenter = self.commentListPresenter()
        self.commentPresenter.fetchCommentItems(commentIds:self.story.kids!)
        self.commentPresenter?.delegate = self
        
        
        self.commentListProvider.commentPresenter = self.commentPresenter
        self.commentsView.tableView.delegate = self.commentListProvider
        self.commentsView.tableView.dataSource = self.commentListProvider
        
        commentsView.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")


    }
    func commentListPresenter() -> CommentPresenter {
           let networkLayer = Network()
           let commentViewModel = CommentViewModel(networkLayer: networkLayer)
           let commentPresenter = CommentPresenter(commentViewModel: commentViewModel)
           return commentPresenter
    }
    @IBAction func comments(_ sender: Any) {
        self.highlight(view: self.commentTab, state: true)
        self.highlight(view: self.webTab, state: false)
        self.scrollView.scrollTo(horizontalPage: 1, animated: true)

    }
    
    @IBAction func details(_ sender: Any) {
        self.highlight(view: self.commentTab, state: false)
        self.highlight(view: self.webTab, state: true)
        self.scrollView.scrollTo(horizontalPage: 0, animated: true)

    }
    
    // MARK: - Can be in other presenter provider

    func addWebViewDetail() {
        self.webDetail = (WebDetail.instanceFromNib() as! WebDetail)
        self.webDetail.frame =  CGRect(x: 0, y:0, width:  self.webDetail.frame.width, height: self.webDetail.frame.height)
        scrollView.addSubview(self.webDetail)
        self.view.addSubview(self.scrollView)
        //load story url
        self.webDetail.webView.load(URLRequest(url:URL(string: self.story.url!)!))

    }
    
    func addCommentsView() {
        self.commentsView = (CommentsView.instanceFromNib() as! CommentsView)
        self.commentsView.frame =  CGRect(x: self.view.frame.width, y:0, width:  self.commentsView.frame.width, height: self.commentsView.frame.height)
        scrollView.addSubview(self.commentsView)
        self.view.addSubview(self.scrollView)

    }

}

extension DetailViewController:CommentPresenterDelegate {
    func didFetchCommentItems(success: Bool) {
        DispatchQueue.main.async {
            self.commentListProvider.comments = self.commentPresenter.commentItems
            self.commentsView.tableView.reloadData()
        }
    }
}

extension DetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    print(pageIndex)
    
    
        
        switch pageIndex {
        case 0:
            self.highlight(view: self.commentTab, state: false)
            self.highlight(view: self.webTab, state: true)
            break
        case 1:
            self.highlight(view: self.commentTab, state: true)
            self.highlight(view: self.webTab, state: false)
            break
        default:
            break
            
        }
    }
}
