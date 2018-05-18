//
//  SwiftTableView.swift
//  TableView
//
//  Created by 韩志峰 on 2018/5/12.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

protocol SwiftTableViewDelegate: NSObjectProtocol {
    func tableView(_ tableView: SwiftTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: SwiftTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: SwiftTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

class SwiftTableView: UIScrollView {
    var swiftdelegate: SwiftTableViewDelegate?
    private var visibleCellDic: [Int: UITableViewCell] = [Int: UITableViewCell]()
    private var reusePoolCellArr: [UITableViewCell] = [UITableViewCell]()
    private var cellInfoArr: [CellModelInfo] = [CellModelInfo]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        self.handleData()
        self.dealUI()
    }
    func dequeueReusableCell(identifier: String, indexpath: IndexPath) -> UITableViewCell{
        var cell: UITableViewCell? = visibleCellDic[indexpath.row]
        if cell == nil {
            if reusePoolCellArr.count > 0 {
              cell = reusePoolCellArr[0]
                reusePoolCellArr.removeFirst()
            }else{
                cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            }
            print("visibleCellDic.count\(visibleCellDic.count)")
            print("reusePoolCellArr.count\(reusePoolCellArr.count)")
            visibleCellDic.updateValue(cell!, forKey: indexpath.row)
        }
        return cell!
    }
    //处理数据
    func handleData(){
        //获取cell的数量和高度并保存起来
        let rowCount = self.swiftdelegate?.tableView(self, numberOfRowsInSection: 0)
        cellInfoArr.removeAll()
        var totalHeight: CGFloat = 0
        for i in 0...rowCount! {
            let cellInfo = CellModelInfo()
            let indexPath = IndexPath.init(row: i, section: 0)
            let cellheight = self.swiftdelegate?.tableView(self, heightForRowAt: indexPath)
            cellInfo.y = totalHeight
            cellInfo.height = cellheight!
            totalHeight += cellheight!
            cellInfoArr.append(cellInfo)
        }
        self.contentSize = CGSize.init(width: self.bounds.width, height: totalHeight)
    }
    //刷新UI
    func dealUI(){
        self.setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 2.1 计算可视范围，要显示哪些cell，并把相关cell显示到界面
        var startY = self.contentOffset.y
        var endY = self.contentOffset.y + self.frame.height
        if startY < 0 {startY = 0}
        if endY > self.contentSize.height {endY = self.contentSize.height}
        // 2.2 计算边界的cell索引 （从哪几个到哪几个cell， 如第3个到第9个）
        let startModel = CellModelInfo()
        startModel.y = startY
        let endModel = CellModelInfo()
        endModel.y = endY
        // 2.3 目地就是获取可视区域显示cell的索引范围
        var startIndex: Int = 0
        var endIndex: Int = 0
        for i in 0...cellInfoArr.count - 1 {
            let model = cellInfoArr[i]
            if model.y <= startY && model.y + model.height > startY{
                startIndex = i
                print("startIndex\(startIndex)")
                break
            }
        }
        for i in (startIndex + 1)...cellInfoArr.count - 1{
            let model = cellInfoArr[i]
            if model.y < endY && model.y + model.height >= endY{
                endIndex = i
                print("endIndex\(endIndex)")
                break
            }
        }
        // 2.4 UI操作 获取cell，并显示到View上
        for i in startIndex...endIndex {
            let indexPath = IndexPath.init(row: i, section: 0)
            let cell : UITableViewCell = (self.swiftdelegate?.tableView(self, cellForRowAt: indexPath))!
            let cellModel = cellInfoArr[i]
            print(cellModel.height)
            cell.frame = CGRect.init(x: 0, y: cellModel.y, width: self.bounds.width, height: cellModel.height)
            self.addSubview(cell)
        }
        // 2.5 从现有池里面移走不在界面上的cell，移动重用池里(把不在可视区域的cell移到重用池)
        let visibleCellKeys = Array(visibleCellDic.keys)
        for i in 0...visibleCellKeys.count - 1{
            let index = visibleCellKeys[i]
            if index < startIndex || index > endIndex{
                reusePoolCellArr.append(visibleCellDic[visibleCellKeys[i]]!)
                visibleCellDic.removeValue(forKey: visibleCellKeys[i])
            }
        }
        
    }
    

}
