//
//  SwiftTableViewViewController.swift
//  TableView
//
//  Created by 韩志峰 on 2018/5/12.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class SwiftTableViewViewController: UIViewController,SwiftTableViewDelegate {
    var tableView: SwiftTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = SwiftTableView.init(frame: self.view.bounds)
        tableView.swiftdelegate = self
        tableView.reloadData()
        self.view.addSubview(tableView)
    }
    func tableView(_ tableView: SwiftTableView, numberOfRowsInSection section: Int) -> Int {
        return 10000
    }
    func tableView(_ tableView: SwiftTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print("cellForRowAt\(indexPath.row)")
        let cell: UITableViewCell = tableView.dequeueReusableCell(identifier: "cell", indexpath: indexPath )
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.red
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: SwiftTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt\(indexPath.row)")
        return 50
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
