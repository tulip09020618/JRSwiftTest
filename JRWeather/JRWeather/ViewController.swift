//
//  ViewController.swift
//  JRWeather
//
//  Created by hqtech on 2018/3/8.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBAction func btnPressed(_ sender: Any) {
        print("点击按钮")
        loadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadWeather() {
        let url = NSURL(string: "http://www.weather.com.cn/data/sk/101010100.html")
        
        let data : NSData! = NSData(contentsOf: url! as URL)
        
        //var str = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
        
        if data == nil {
            return
        }
       
        let json : AnyObject!
        do {
            json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
        } catch {
            print("json error：\(error)")
            return
        }
        
        print(json)
        
        let weatherInfo : AnyObject! = json.object(forKey: "weatherinfo") as AnyObject
        
        let city = weatherInfo.object(forKey: "city") as! String
        
        let temp = weatherInfo.object(forKey: "temp") as! String
        
        let wind = weatherInfo.object(forKey: "WD") as! String
        
        textView.text = "城市：\(city)\n温度：\(temp)\n风向：\(wind)"
    }

}

