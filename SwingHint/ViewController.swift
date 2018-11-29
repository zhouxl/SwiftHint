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

    let hintView = SwingHint()
    var topY: CGFloat = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        let hint: String = "爱笑的人运气不会太差"
        hintView.showText(hint)
        hintView.topCenter = CGPoint(x: 0, y: 200)
        view.addSubview(hintView)

    }

    @IBAction func buttonAction() {
        topY += 30
        hintView.topCenter = CGPoint(x: 0, y: topY)
        hintView.showText("越努力，越幸运")
    }

}
