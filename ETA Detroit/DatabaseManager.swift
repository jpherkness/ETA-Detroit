//
//  DBManager.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/19/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import Foundation
import FMDB

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    var DDOTRoutesDatabase: FMDatabase!
    var smartRoutesDatabase: FMDatabase!
    var reflexDatabase: FMDatabase!
    
    init() {
        prepareDatabases()
    }
    
    func prepareDatabases() {
        
        // Create an connect to the DDOTRoutes database
        let sourcePath = Bundle.main.path(forResource: "DDOTRoutes", ofType: "sqlite")
        DDOTRoutesDatabase = FMDatabase(path: sourcePath)
    }
    
    func getDDOTRoutes() -> Array<Route> {
        
        // An array of routes that will be returned
        var routes = Array<Route>()
        
        // Open the connection
        guard DDOTRoutesDatabase!.open() else {
            print("Unable to open database")
            return routes
        }
        
        // Load all the rows as route objects and return them
        do {
            let rs = try DDOTRoutesDatabase?.executeQuery("select * from 'route'", values: nil)
            while rs!.next() {
                if let company = rs!.string(forColumn: "Company"),
                    let routeID = rs!.string(forColumn: "rt"),
                    let number = rs!.string(forColumn: "rtnum"),
                    let name = rs!.string(forColumn: "rtnm"),
                    let direction1 = rs!.string(forColumn: "direction1"),
                    let direction2 = rs!.string(forColumn: "direction2"),
                    let active = rs!.string(forColumn: "routeActive")
                    {
                        routes.append(
                            Route(company: company,
                                  routeID: routeID,
                                  number: number,
                                  name: name.lowercased().capitalized,
                                  direction1: direction1,
                                  direction2: direction2,
                                  active: active,
                                  days: nil))
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        // Close the connection
        DDOTRoutesDatabase.close()
        
        return routes
    }
    
}
