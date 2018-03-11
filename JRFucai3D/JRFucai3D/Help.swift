//
//  Help.swift
//  JRFucai3D
//
//  Created by hqtech on 2018/3/10.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

// 定义全局变量

// 屏幕的宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

// 弹出提示信息
func showMessage(title: String?, message: String?, okTitle: String?, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    // 添加确认按钮
    alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}
