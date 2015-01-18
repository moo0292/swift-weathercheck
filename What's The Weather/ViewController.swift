//
//  ViewController.swift
//  What's The Weather
//
//  Created by Kittitat Rodchaidee on 1/16/15.
//  Copyright (c) 2015 Kittitat Rodchaidee. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!

    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.view.endEditing(true)
       var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        var url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response,error) in
            
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let tempurlContent = urlContent as String
            println(tempurlContent.rangeOfString("<span class=\"phrase\">"))
            
            if (tempurlContent.rangeOfString("<span class=\"phrase\">") != nil) {
                

                var contentArray = urlContent!.componentsSeparatedByString("<span class=\"phrase\">") as Array
                
                var newContentArray = contentArray[1].componentsSeparatedByString("</span>") as Array
                println(newContentArray[0])
                
                dispatch_async(dispatch_get_main_queue()){
                    self.message.text = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as String
                }
            } else {
                self.message.text = "Couldn't find that city please try again"
            }
        }
        
        task.resume()
       //println(urlString)
    }


}

