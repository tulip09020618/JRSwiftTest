//: Playground - noun: a place where people can play

import UIKit

var url = NSURL(string: "http://www.weather.com.cn/data/sk/101010100.html")

var data = NSData(contentsOf: url! as URL)

//var str = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
var json : AnyObject! = try? JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject

var weatherInfo : AnyObject! = json.object(forKey: "weatherinfo") as AnyObject

var city : AnyObject! = weatherInfo.object(forKey: "city") as AnyObject

var temp : AnyObject! = weatherInfo.object(forKey: "temp") as AnyObject

var wind : AnyObject! = weatherInfo.object(forKey: "WD") as AnyObject







