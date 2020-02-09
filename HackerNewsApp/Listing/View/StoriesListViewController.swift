//
//  ViewController.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

class StoriesListViewController: UIViewController {
    @IBOutlet weak var storiesTableView: UITableView!
    @IBOutlet var storiesListProvider: StoriesListProvider!
    var storiesPresenter:StoriesPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storiesPresenter = self.storiesListPresenter()
        self.storiesPresenter?.fetchStoriesItems()
        self.storiesPresenter?.delegate = self
        
        self.storiesListProvider.storiesPresenter = self.storiesPresenter
        self.storiesTableView.delegate = self.storiesListProvider
        self.storiesTableView.dataSource = self.storiesListProvider
    }

    func storiesListPresenter() -> StoriesPresenter {
           let networkLayer = Network()
           let storiesViewModel = StoriesViewModel(networkLayer: networkLayer)
           let storiesPresenter = StoriesPresenter(storiesViewModel: storiesViewModel)
           return storiesPresenter
    }
}

extension StoriesListViewController:StoriesPresenterDelegate {
    func didFetchStoriesItems(success: Bool) {
        DispatchQueue.main.async {
            self.storiesTableView.reloadData()
        }
    }
    
}
