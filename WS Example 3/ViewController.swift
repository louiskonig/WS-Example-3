//
//  ViewController.swift
//  WS Example 3
//
//  Created by Louis Konig on 12/6/14.
//  Copyright (c) 2014 Louis Konig. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var myNameLabel: LTMorphingLabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myNameLabel.alpha = 0.0 //Hide The label until we get the data 
        let activityIndictorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndictorView.center = self.view.center
        self.view.addSubview(activityIndictorView)
        activityIndictorView.startAnimating()
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "http:/graph.facebook.com/louiskonig",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                if let myName = responseObject.valueForKey("name") as? String {
                    
                    
                    self.myNameLabel.morphingEffect = .Sparkle
                    self.myNameLabel.text = myName
                    activityIndictorView.stopAnimating()
                    
                    
                    UIView.animateWithDuration(1.0, animations: {
                        self.myNameLabel.alpha = 1.0
                        }, completion: {
                            (value: Bool) in
                            println("Animation complete!") })
                    
                    
                  
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    

    
   
    
}

