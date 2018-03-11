//
//  JRQueryViewController.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/10.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit
import Alamofire

class JRQueryViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 查询开奖结果
        queryData(10)
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
    
    // MARK: 查询开奖数据
    // nums: 要查询的总期数
    func queryData(_ nums: Int) {
        //http://f.apiplus.net/fc3d-20.json
        // 拼接请求地址
        let requestStr = "http://f.apiplus.net/fc3d-\(nums).json"
        // 请求url
        let requestUrl: URL! = URL(string: requestStr)
        print("请求地址：\(requestUrl)")
        
        // 请求开奖数据
        Alamofire.request(requestStr).responseJSON {response in
            if response.error == nil {
                // 请求成功
                let results = response.result.value
                // 解析数据
                self.parseData(results!)
            }else {
                print("请求错误:\(response.error!)")
                self.textView.text = "请求错误:\(response.error!)"
            }
        }
    }
    
    // 解析开奖结果数据
    func parseData(_ result: Any?) {
        if result == nil {
            print("请求结果为空")
            textView.text = "请求结果为空"
            return
        }

        let dic = result as! Dictionary<String, AnyObject>
        let data = dic["data"] as! Array<Dictionary<String, AnyObject>>
        
        if data.count == 0 {
            print("无数据")
            textView.text = "无数据"
            return
        }
        
        // 获取第一条数据
        let firstData = data[0]
        // 开奖号码
        let opencode = firstData["opencode"] as! String
        // 开奖时间
        let opentime = firstData["opentime"] as! String
        // 开奖期数
        let expect = firstData["expect"] as! String
        
        let queryResult = "开奖期数：\(expect)\n\n开奖时间：\(opentime)\n\n开奖号码：\(opencode)"
        textView.text = queryResult
        print(queryResult)
    }

}
