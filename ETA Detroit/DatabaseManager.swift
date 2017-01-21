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
    
    private var database: FMDatabase!
    
    
    // MARK: NSObject
    
    override init() {
        super.init()
        initalizeDatabases()
    }
    
    
    // MARK: Public
    
    func initalizeDatabases() {
        
        let DDOTRoutesDatabaseSourcePath = Bundle.main.path(forResource: "ETADetroit", ofType: "db")
        database = FMDatabase(path: DDOTRoutesDatabaseSourcePath)
    
    }
    
    func getDDOTRoutes() -> [Route] {
        
        var routes = [Route]()
        
        guard database.open() else {
            print("Unable to open database")
            return routes
        }
        
        do {
            let rs = try database.executeQuery("select * from 'DDOT Routes' where Company='DDOT'", values: nil)
            while rs.next() {
                
                let company = rs.string(forColumn: "Company")
                let routeID = rs.string(forColumn: "rt")
                let number = rs.string(forColumn: "rtnum")
                let name = rs.string(forColumn: "rtnm")
                let direction1 = rs.string(forColumn: "direction1")
                let direction2 = rs.string(forColumn: "direction2")
                let active = rs.string(forColumn: "routeActive")
                
                let normalizedString = name?.lowercased().capitalized
                
                let route = Route(company: company,
                                  routeID: routeID,
                                  number: number,
                                  name: normalizedString,
                                  direction1: direction1,
                                  direction2: direction2,
                                  active: active == "Active",
                                  days: nil)
                routes.append(route)
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return routes
    }
    
    func getSmartRoutes() -> [Route] {
        
        var routes = [Route]()
        
        guard database.open() else {
            print("Unable to open database")
            return routes
        }
        
        do {
            let rs = try database.executeQuery("select * from 'Smart Bus Routes' where Company='SmartBus'", values: nil)
            while rs.next() {
                
                let company = rs.string(forColumn: "Company")
                let routeID = rs.string(forColumn: "rtid")
                let number = rs.string(forColumn: "rtid")
                let name = rs.string(forColumn: "rtnm")
                let direction1 = rs.string(forColumn: "direction1")
                let direction2 = rs.string(forColumn: "direction2")
                let active = rs.string(forColumn: "routeActive")
                let days = rs.string(forColumn: "Days")
                    
                let normalizedName = name?.lowercased().capitalized.replacingOccurrences(of: (routeID?.appending(" - "))!, with: "")
                let daysArray = days?.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
                
                let route = Route(company: company,
                                  routeID: routeID,
                                  number: number,
                                  name: normalizedName,
                                  direction1: direction1,
                                  direction2: direction2,
                                  active: active == "Active",
                                  days: daysArray)
                routes.append(route)
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return routes
    }
    
    func getDDOTStopsFor(route: Route) -> [Stop] {
        
        var stops = [Stop]()
        
        guard database.open() else {
            print("Unable to open database")
            return stops
        }
        
        guard let routeID = route.routeID else {
            print("Route not valid")
            return stops
        }
        
        do {
            let rs = try database.executeQuery("select * from 'DDOT Stops' where Company='DDOT' and rt='\(routeID)'", values: nil)
            while rs.next() {
                let name = rs.string(forColumn: "stpnm")
                let number = rs.string(forColumn: "stnum")
                let direction = rs.string(forColumn: "dir")
                let latitude = rs.double(forColumn: "lat")
                let longitude = rs.double(forColumn: "long")
                let active = rs.string(forColumn: "stopActive")
                
                let normalizedName = name?.lowercased().capitalized //TODO: Not sure if I should normalize these properties here
                
                let stop = Stop(name: normalizedName,
                                number: number,
                                direction: direction,
                                latitude: latitude,
                                longitude: longitude,
                                active: active == "Active")
                stops.append(stop)
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return stops
    }
    
}
