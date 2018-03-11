//
//  JRPredictionViewController.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/10.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

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
