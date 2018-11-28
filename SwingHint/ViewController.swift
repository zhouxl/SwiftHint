//
//  ViewController.swift
//  SwingHint
//
//  Created by 小六 on 2018/11/28.
//  Copyright © 2018 小六. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hint: String = "爱笑的人运气都好"
        let hintView = SwingHint()
        hintView.topCenter = CGPoint(x: 100, y: 200)
        view.addSubview(hintView)
        hintView.updateText(hint)
    }
}
