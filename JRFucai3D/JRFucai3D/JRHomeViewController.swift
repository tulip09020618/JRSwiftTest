//
//  JRHomeViewController.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/10.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

class JRHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    // 数据源
    var dataSource: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "福彩3D"
        
        // 初始化数据源
        dataSource = [String]()
        dataSource.append("开奖查询")
        dataSource.append("独胆预测")
        dataSource.append("双胆预测")
        
        // 设置tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "fucai"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        print(dataSource[indexPath.row])
        
        if indexPath.row == 0 {
            // 开奖查询
            let queryVC = JRQueryViewController(nibName: "JRQueryViewController", bundle: nil)
            queryVC.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(queryVC, animated: true)
        }else if indexPath.row == 1 {
            // 独胆预测
            let onlyPredictionVC = JRPredictionViewController(nibName: "JRPredictionViewController", bundle: nil)
            onlyPredictionVC.title = dataSource[indexPath.row]
            onlyPredictionVC.predictType = PREDICTION_TYPE.PREDICTION_TYPE_ONLE
            self.navigationController?.pushViewController(onlyPredictionVC, animated: true)
        }else if indexPath.row == 2 {
            let doublePredictionVC = JRPredictionViewController(nibName: "JRPredictionViewController", bundle: nil)
            doublePredictionVC.title = dataSource[indexPath.row]
            doublePredictionVC.predictType = PREDICTION_TYPE.PREDICTION_TYPE_DOUBLE
            self.navigationController?.pushViewController(doublePredictionVC, animated: true)
        }
    }

}
