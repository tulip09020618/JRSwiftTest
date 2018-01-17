//
//  ViewController.swift
//  JRSwiftTest
//
//  Created by hqtech on 2018/1/14.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var someInts = [Int](repeating: 5, count: 5);
        
        var someVar = someInts[0]
        someVar = 20;
        
        print( "第一个元素的值 \(someVar)" )
        print( "第二个元素的值 \(someInts[1])" )
        print( "第三个元素的值 \(someInts[2])" )
        print(someInts)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toFirstVC(_ sender: Any) {
        let firstVC:JRFirstViewController = JRFirstViewController.init(nibName: "JRFirstViewController", bundle: nil);
        self .present(firstVC, animated: true, completion: nil);
    }
    
}

