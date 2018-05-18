//
//  ViewController.swift
//  TableView
//
//  Created by 韩志峰 on 2018/5/12.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func swiftTableViewDidClick(_ sender: UIButton) {
        let systemVC = SwiftTableViewViewController()
        self.navigationController?.pushViewController(systemVC, animated: true)
    }
    @IBAction func systmeTableViewDidClick(_ sender: UIButton) {
        let systemVC = SystemTableVC()
        self.navigationController?.pushViewController(systemVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }


}

