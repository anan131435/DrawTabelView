//
//  SysTemVC.swift
//  TableView
//
//  Created by 韩志峰 on 2018/5/12.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import Foundation
import UIKit
class SystemTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tabelView: UITableView!
    let cellIdentifier: String = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.estimatedRowHeight = 0
        tabelView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tabelView)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print("cellForRowAt" + "\(indexPath.row)")
        let cell: UITableViewCell = tabelView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let bgColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.gray
        cell.backgroundColor = bgColor
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
         print("numberOfRowsInSection")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return 10000
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt" + "\(indexPath.row)")
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabelView.reloadData()
    }
}
