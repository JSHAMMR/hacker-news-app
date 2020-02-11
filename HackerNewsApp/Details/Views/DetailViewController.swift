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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.highlight(view: self.commentTab, state: true)
        self.highlight(view: self.webTab, state: false)
        // Do any additional setup after loading the view.
    }
    
    
    func highlight (view:UIView , state: Bool) {
        let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: view.frame.height - 2, width: view.frame.width, height: 2.0)
        if state {
            bottomLine.backgroundColor = UIColor.red.cgColor
        } else {
            bottomLine.backgroundColor = UIColor.gray.cgColor
        }
            view.layer.addSublayer(bottomLine)
     }
    
    @IBAction func comments(_ sender: Any) {
        self.highlight(view: self.commentTab, state: true)
        self.highlight(view: self.webTab, state: false)

    }
    
    @IBAction func details(_ sender: Any) {
        self.highlight(view: self.commentTab, state: false)
        self.highlight(view: self.webTab, state: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
