//
//  JRPredictionViewController.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/10.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit
import Alamofire

enum PREDICTION_TYPE: Int {
    case PREDICTION_TYPE_ONLE // 独胆
    case PREDICTION_TYPE_DOUBLE // 双胆
}

class JRPredictionViewController: UIViewController {
    
    // 预测类型
    var predictType: PREDICTION_TYPE!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if predictType == PREDICTION_TYPE.PREDICTION_TYPE_ONLE {
            print("独胆")
        }else {
            print("双胆")
        }
        
        // 查询最近20期开奖结果
        queryData(20)
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
                showMessage(title: "提示", message: "请求错误:\(response.error!)", okTitle: "确定", vc: self)
            }
        }
    }
    
    // 解析开奖结果数据
    func parseData(_ result: Any?) {
        if result == nil {
            print("请求结果为空")
            showMessage(title: "提示", message: "请求结果为空", okTitle: "确定", vc: self)
            return
        }
        
        let dic = result as! Dictionary<String, AnyObject>
        let data = dic["data"] as! Array<Dictionary<String, AnyObject>>
        
        if data.count == 0 {
            print("无数据")
            showMessage(title: "提示", message: "无数据", okTitle: "确定", vc: self)
            return
        }
        
        var queryResult = ""
        var queryArr: Array<Array<String>>! = [Array<String>]()
        for i in 0..<data.count {
            let dataDic = data[i]
            
            // 开奖号码
            let opencode = dataDic["opencode"] as! String
            // 开奖时间
            var opentime = dataDic["opentime"] as! String
            opentime = String(opentime.prefix(10))
//            // 开奖期数
//            let expect = dataDic["expect"] as! String
            // 预测结果
            var predict: String = ""
            if predictType == PREDICTION_TYPE.PREDICTION_TYPE_ONLE {
                // 独胆预测
                predict = predictWithOnly(opencode: opencode)
            }else {
                // 双胆预测
                predict = predictWithDouble(opencode: opencode)
            }
            
            queryResult.append("\n时间：\(opentime)，号码：\(opencode)，预测：\(predict)")
            queryArr.append([opentime, opencode, predict])
        }
        
        showMessage(title: "开奖结果\(data.count)", message: queryResult, okTitle: "确定", vc: self)
        print(queryResult)
        
    }
    
    // MARK: 独胆预测
    func predictWithOnly(opencode: String) -> String {
        let arr = opencode.split(separator: ",")
        if arr.count != 3 {
            print("解析错误")
            return "-"
        }
        
        let a: Int! = Int(arr[0]) // 百位
        let b: Int! = Int(arr[1]) // 十位
        let c: Int! = Int(arr[2]) // 个位
        
        // 根据开奖数求预测结果
        // 公式：上期奖号(百位乘以4+十位乘以9+个位乘以9+3)除以10，取余数
        var s = a * 4
        s += b * 9
        s += c * 9
        s %= 10
        
        return "\(s)"
    }
    
    // MARK: 双胆预测
    func predictWithDouble(opencode: String) -> String {
        
        let arr = opencode.split(separator: ",")
        if arr.count != 3 {
            print("解析错误")
            return "-"
        }
        
        let a: Int! = Int(arr[0]) // 百位
        let b: Int! = Int(arr[1]) // 十位
        let c: Int! = Int(arr[2]) // 个位
        
        // 根据开奖数求预测结果
        // 公式：上期奖号(百位乘以147+十位乘以258+个位乘以369)乘以179，删除同号后取结果的最后3位
        var s = a * 147
        s += b * 258
        s += c * 369
        s *= 179
        
        // 取不重复的后三位
        var numArr: Array<String> = [String]()
        while s > 0 {
            let n = s % 10
            s /= 10
            if !numArr.contains("\(n)") {
                numArr.append("\(n)")
            }else {
                continue
            }
        }
        
        if numArr.count < 3 {
            return "-"
        }
        return "\(numArr[numArr.count-3]),\(numArr[numArr.count-2]),\(numArr[numArr.count-1])"
    }
    
}
