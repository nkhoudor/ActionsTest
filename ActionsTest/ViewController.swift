//
//  ViewController.swift
//  ActionsTest
//
//  Created by Admin on 08/04/2020.
//  Copyright © 2020 Rocket. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    let jsonStr = "{\"name\" : \"test2\"}"
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let json = JSON(parseJSON: jsonStr)
        label.text = json["name"].stringValue
        // Do any additional setup after loading the view.
    }


}

