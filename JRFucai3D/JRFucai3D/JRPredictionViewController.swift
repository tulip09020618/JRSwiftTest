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
    
    @IBOutlet weak var textView: UITextView!
    
    // 预测类型
    var predictType: PREDICTION_TYPE!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
            
            queryArr.append([opentime, opencode, predict])
        }
        
        // 处理预测（向前移动一位）
        var queryResult = ""
        var nextPredict = "" // 下期预测结果
        var count1 = 0 // 猜中一个数的次数
        var count2 = 0 // 猜中两个数的次数
        var count3 = 0 // 猜中三个数的次数
        for i in 0..<queryArr.count {
            var currentArr = queryArr[i]
            if i == 0 {
                // 第一个即为下期预测结果
                nextPredict = currentArr[2]
                queryResult.append("下期预测：\(nextPredict)")
            }else {
                // 预测结果前移
                var lastArr = queryArr[i-1]
                lastArr[2] = currentArr[2]
                
                let winCount = isWin(result: lastArr[1], predict: lastArr[2])
                var winStr = "否"
                if winCount == 1 {
                    winStr = "中"
                    count1 += 1
                }else if winCount == 2 {
                    winStr = "中"
                    count2 += 1
                }else if winCount == 3 {
                    winStr = "中"
                    count3 += 1
                }
                queryResult.append("\n\(lastArr[0]): \(lastArr[1])\t预：\(lastArr[2])\t奖：\(winStr)")
                
                // 处理最后一个数组
                if i == queryArr.count - 1 {
                    currentArr[2] = "-"
                    queryResult.append("\n\(currentArr[0]): \(currentArr[1])\t预：\(currentArr[2])\t奖：-")
                }
            }
        }
        
        if predictType == PREDICTION_TYPE.PREDICTION_TYPE_DOUBLE {
            queryResult.append("\n猜中1个：\(count1)次\t中奖概率：\(String(format: "%.2f", Double(count1)/19.0*100))%")
            queryResult.append("\n猜中2个：\(count2)次\t中奖概率：\(String(format: "%.2f", Double(count2)/19.0*100))%")
            queryResult.append("\n猜中3个：\(count3)次\t中奖概率：\(String(format: "%.2f", Double(count3)/19.0*100))%")
        }
        
        // 总中奖次数
        let totalCount = count1 + count2 + count3
        
//        showMessage(title: "开奖结果\(String(format: "%.2f", Double(totalCount)/19.0*100))%", message: queryResult, okTitle: "确定", vc: self)
        
        queryResult = "开奖结果\n中奖概率：\(String(format: "%.2f", Double(totalCount)/19.0*100))%\n" + queryResult
        textView.text = queryResult
        print(queryResult)
        
    }
    
    // MARK: 独胆预测
    func predictWithOnly(opencode: String) -> String {
        let arr = opencode.split(separator: ",")
        if arr.count != 3 {
            showMessage(title: "独胆预测", message: "解析错误", okTitle: "确定", vc: self)
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
            showMessage(title: "胆码预测", message: "解析错误", okTitle: "确定", vc: self)
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
    
    // MARK: 判断是否中奖
    func isWin(result: String?, predict: String?) -> Int {
        if result == nil || predict == nil {
            print("数据有问题")
            showMessage(title: "胆码预测", message: "数据有问题", okTitle: "确定", vc: self)
            return 0
        }
        
        if predict! == "_" {
            print("最后一期，无法预测")
            return 0
        }
        
        let arr = predict?.split(separator: ",")
        var count = 0
        for i in 0..<arr!.count {
            let p = arr![i]
            let index = result!.index(of: Character(String(p)))
            if index != nil {
                count += 1
            }
        }
        
        return count
    }
    
}
