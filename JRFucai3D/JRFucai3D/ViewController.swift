//
//  ViewController.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/8.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var dataSource : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 初始化数据源
        dataSource = [String]()
        for i in 1...10 {
            dataSource.append("第\(i)行")
        }
        
        // 创建tableView
        tableView = UITableView(frame: CGRect(x: 0,y : 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-20), style: UITableViewStyle.plain);
        self.view.addSubview(tableView);
        tableView.backgroundColor = UIColor.red
        
        // 设置代理
        tableView.delegate = self
        tableView.dataSource = self
        
        // 去掉无数据行的显示
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 设置行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // 设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        let title = dataSource[indexPath.row]
        cell?.textLabel?.text = title
        
        return cell!
    }
    
    // 选中cell触发的方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 选中后消除选中效果
        tableView .deselectRow(at: indexPath, animated: true)
        
        print("选中了第\(indexPath.row)行")
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

