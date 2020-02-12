//
//  DetailViewController.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    @IBOutlet weak var commentTab: UIButton!
    @IBOutlet weak var webTab: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var story:Story!
    fileprivate var webDetail:WebDetail! // for detail tab
    fileprivate var commentsView:CommentsView! // for comments tab
    var commentPresenter:CommentPresenter! // mapping between view model and contrller
    @IBOutlet var commentListProvider: CommentListProvider! // to feed the uis

    override func viewDidLoad() {
        super.viewDidLoad()

        self.highlight(view: self.commentTab, state: false) // highlight the selected tab
        self.highlight(view: self.webTab, state: true)
        // Do any additional setup after loading the view.
        //
        scrollView.isPagingEnabled = true // enable pagination on scroll view
        scrollView.delegate = self // to update tabs
        // add webview to scrollview
        self.addCommentsView() // adding first tab which is comments
        self.addWebViewDetail() // adding second tab which is webview details

        scrollView.contentSize = CGSize(width: self.webDetail.frame.size.width + UIScreen.main.bounds.width, height: self.view.frame.height )
        /////
        // Do any additional setup after loading the view.
        self.commentPresenter = self.commentListPresenter() // presenter instance
        self.commentPresenter.fetchCommentItems(commentIds:self.story.kids!) // getting the comments from presetner
        self.commentPresenter?.delegate = self // listen when the fetching is done
        
        
        self.commentListProvider.commentPresenter = self.commentPresenter // integarte provider and presnenter
        self.commentsView.tableView.delegate = self.commentListProvider // assigin delegate and data source
        self.commentsView.tableView.dataSource = self.commentListProvider
        
        commentsView.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell") // register cell to comments tableview


    }
    // mapping presenter->viewmodel->network
    func commentListPresenter() -> CommentPresenter {
           let networkLayer = Network()
           let commentViewModel = CommentViewModel(networkLayer: networkLayer)
           let commentPresenter = CommentPresenter(commentViewModel: commentViewModel)
           return commentPresenter
    }
    // second tab (comments)
    @IBAction func comments(_ sender: Any) {
        self.highlight(view: self.commentTab, state: true)
        self.highlight(view: self.webTab, state: false)
        self.scrollView.scrollTo(horizontalPage: 1, animated: true)

    }
    // first tab (details)

    @IBAction func details(_ sender: Any) {
        self.highlight(view: self.commentTab, state: false)
        self.highlight(view: self.webTab, state: true)
        self.scrollView.scrollTo(horizontalPage: 0, animated: true)

    }
    
    // MARK: - Can be in other presenter provider

    //adding first tab to scrollview  (details)
    func addWebViewDetail() {
        self.webDetail = (WebDetail.instanceFromNib() as! WebDetail)
        self.webDetail.frame =  CGRect(x: 0, y:0, width:  UIScreen.main.bounds.width, height: self.webDetail.frame.height)
        scrollView.addSubview(self.webDetail)
        self.view.addSubview(self.scrollView)
        //load story url
        self.webDetail.webView.load(URLRequest(url:URL(string: self.story.url!)!))

        self.webDetail.webView.navigationDelegate = self
    }
    //adding second tab to scrollview  (comments)

    func addCommentsView() {
        self.commentsView = (CommentsView.instanceFromNib() as! CommentsView)
        self.commentsView.frame =  CGRect(x: UIScreen.main.bounds.width, y:0, width:  UIScreen.main.bounds.width, height: self.commentsView.frame.height)
        scrollView.addSubview(self.commentsView)
        self.view.addSubview(self.scrollView)

    }

}
// update the contoller using presnerter delegate
extension DetailViewController:CommentPresenterDelegate {
    func didFetchCommentItems(success: Bool) {
        DispatchQueue.main.async {
            self.commentListProvider.comments = self.commentPresenter.commentItems
            self.commentsView.tableView.reloadData()
        }
    }
}
// update the tabs using  UIScrollViewDelegate

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
// update the details using  WKNavigationDelegate

extension DetailViewController:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webDetail.loader.stopAnimating()
    }
}
