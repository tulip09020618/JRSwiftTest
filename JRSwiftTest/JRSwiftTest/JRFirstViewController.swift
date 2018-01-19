//
//  JRFirstViewController.swift
//  JRSwiftTest
//
//  Created by hqtech on 2018/1/17.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

class JRFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func goback(_ sender: Any) {
        self .dismiss(animated: true, completion: nil);
    }
    
    // MARK: 生成随机数
    @IBAction func getRandomNum(_ sender: Any) {
        
        print("-------------------------------")
        var resultStr = ""
        for _ in 0..<5 {
            resultStr += ("\n" + createRandomNum())
        }
        
        print(resultStr)
        
        let alertController = UIAlertController(title: "随机结果",
                                                message: resultStr, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: 生成随机数
    func createRandomNum() -> String {
        var randomNum = "红球：";
        var randomArr = [UInt32](repeating: 0, count: 6);
        for i in 0..<6 {
            var redNum = arc4random() % 33 + 1;
            
            //去掉重复数据
            while randomArr.contains(redNum) {
                redNum = arc4random() % 33 + 1;
            }
            
            randomArr[i] = redNum;
        }
        //数组升序排序
        randomArr.sort() { (s1, s2) -> Bool in
            return s1 < s2
        };
        
        for item in randomArr {
            
            randomNum += " \(String(format:"%02d", item))"
        }
        
        let blueNum = arc4random() % 16 + 1;
        randomNum += " 篮球：\(String(format:"%02d", blueNum))"
        return randomNum;
    }
}
