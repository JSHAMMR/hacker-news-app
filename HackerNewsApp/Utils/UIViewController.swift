//
//  UIViewController.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 12/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import UIKit

extension UIViewController {
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
    
}
