//
//  Route.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/19/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import Foundation

class Route {
    
    var company: String?
    var routeID: String?
    var number: String?
    var name: String?
    var direction1: String?
    var direction2: String?
    var active: String?
    var days: Array<String>?
    
    init(company: String?, routeID: String?, number: String?, name: String?, direction1: String?, direction2: String?, active: String?, days: Array<String>?) {
        self.company = company
        self.routeID = routeID
        self.number = number
        self.name = name
        self.direction1 = direction1
        self.direction2 = direction2
        self.active = active
        self.days = days
    }
}
