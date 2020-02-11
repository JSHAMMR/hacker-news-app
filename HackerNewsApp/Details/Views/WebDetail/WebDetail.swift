//
//  WebDetail.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 12/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit
import WebKit
class WebDetail: UIView {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!

    override func draw(_ rect: CGRect) {
        self.loader.hidesWhenStopped = true
    }
    
    class func instanceFromNib() -> UIView {
         return UINib(nibName:"WebDetail", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
     }
}
