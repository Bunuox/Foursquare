//
//  ViewController.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 23.10.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, err in
            
            if err != nil{
                print(err?.localizedDescription ?? "Error")
            }else{
                print("uploaded")
            }
        }
         */
        let query = PFQuery(className: "Fruits")
        query.findObjectsInBackground { objects, err in
            
            if err != nil {
                print(err?.localizedDescription ?? "Error")
            }
            else{
                print(objects)
            }
        }
        
    }


}

