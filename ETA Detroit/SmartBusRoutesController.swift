//
//  SmartBusRoutesController.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/19/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class SmartBusRoutesController: RoutesController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare() {
        super.prepare()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.24, blue:0.27, alpha:1.00)
        title = "Detroit Smart Bus Routes"
        view.backgroundColor = UIColor.white
    }
    
    override func loadRoutes() {
        super.loadRoutes()
    }


}
