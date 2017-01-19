//
//  DDOTRoutesControllerViewController.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/19/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit
import SnapKit

class RoutesController: UITableViewController {
    
    var routes = Array<Route>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        loadRoutes()
    }
    
    func loadRoutes() { }
    
    func prepare() {
        tableView.register(RouteCell.self, forCellReuseIdentifier: "RouteCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension RoutesController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        cell.accessoryType = .disclosureIndicator
        cell.configureCell(route: routes[indexPath.row])
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
}

extension RoutesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
