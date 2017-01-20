/**
 * Copyright (c) 2017 RIIS LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Author: Joseph Herkness
 */

import Foundation

import FMDB


// MARK: - DatabaseManager

class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    
    
    // MARK: Private
    
    private var DDOTRoutesDatabase: FMDatabase!
    private var smartRoutesDatabase: FMDatabase!
    private var reflexDatabase: FMDatabase!
    
    
    // MARK: NSObject
    
    override init() {
        super.init()
        initalizeDatabases()
    }
    
    
    // MARK: Public
    
    func initalizeDatabases() {
        
        let DDOTRoutesDatabaseSourcePath = Bundle.main.path(forResource: "DDOTRoutes", ofType: "sqlite")
        DDOTRoutesDatabase = FMDatabase(path: DDOTRoutesDatabaseSourcePath)
        
        let smartRoutesDatabaseSourcePath = Bundle.main.path(forResource: "SmartRoutes", ofType: "sqlite")
        smartRoutesDatabase = FMDatabase(path: smartRoutesDatabaseSourcePath)
    }
    
    func getDDOTRoutes() -> Array<Route> {
        
        // An array of routes that will be returned
        var routes = Array<Route>()
        
        // Open the connection
        guard DDOTRoutesDatabase.open() else {
            print("Unable to open DDOTRoutesDatabase")
            return routes
        }
        
        // Load all the rows as route objects and return them
        if DDOTRoutesDatabase != nil {
            do {
                let rs = try DDOTRoutesDatabase.executeQuery("select * from 'route' where Company='DDOT'", values: nil)
                while rs.next() {
                    if let company = rs.string(forColumn: "Company"),
                        let routeID = rs.string(forColumn: "rt"),
                        let number = rs.string(forColumn: "rtnum"),
                        let name = rs.string(forColumn: "rtnm"),
                        let direction1 = rs.string(forColumn: "direction1"),
                        let direction2 = rs.string(forColumn: "direction2"),
                        let active = rs.string(forColumn: "routeActive")
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
        }
        
        // Close the connection
        DDOTRoutesDatabase.close()
        
        return routes
    }
    
    func getSmartRoutes() -> [Route] {
        
        var routes = [Route]()
        
        // Open the connection, return if there is an issue
        guard smartRoutesDatabase.open() else {
            print("Unable to open SmartRoutesDatabase")
            return routes
        }
        
        // Load all the rows as route objects and return them
        if smartRoutesDatabase != nil {
            do {
                let rs = try smartRoutesDatabase.executeQuery("select * from 'route' where Company='SmartBus'", values: nil)
                while rs.next() {
                    if let company = rs.string(forColumn: "Company"),
                        let routeID = rs.string(forColumn: "rtid"),
                        let number = rs.string(forColumn: "rtid"),
                        let name = rs.string(forColumn: "rtnm"),
                        let direction1 = rs.string(forColumn: "direction1"),
                        let direction2 = rs.string(forColumn: "direction2"),
                        let active = rs.string(forColumn: "routeActive"),
                        let days = rs.string(forColumn: "Days")
                    {
                        routes.append(
                            Route(company: company,
                                  routeID: routeID,
                                  number: number,
                                  name: name.lowercased().capitalized,
                                  direction1: direction1,
                                  direction2: direction2,
                                  active: active,
                                  days: days.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")))
                    }
                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
        }
        
        // Close the connection
        smartRoutesDatabase.close()
        
        return routes
    }
    
}
