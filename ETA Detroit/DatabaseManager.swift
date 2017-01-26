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
        
        let DDOTRoutesDatabaseSourcePath = Bundle.main.path(forResource: "ETADetroitSchedule", ofType: "db")
        database = FMDatabase(path: DDOTRoutesDatabaseSourcePath)
    
    }
    
    func getDDOTRoutes() -> [Route] {
        return getRoutesFor(company: "DDOT")
    }
    
    func getSmartRoutes() -> [Route] {
        return getRoutesFor(company: "SmartBus")
    }
    
    func getReflexRoutes() -> [Route] {
        return getRoutesFor(company: "RefleX")
    }
    
    func getRoutesFor(company: String) -> [Route] {
        
        var routes = [Route]()
        
        guard database.open() else {
            print("Error: Database could not be opened")
            return routes
        }
        
        guard let rs = database.executeQuery("select * from 'Routes' where company='\(company)'", withArgumentsIn: nil) else {
            print("Error: Could not find any routes for company: \(company)")
            return routes
        }
        
        while rs.next() {
            
            let company = rs.string(forColumn: "company")
            let routeID = rs.string(forColumn: "route_id")
            let number = rs.string(forColumn: "route_number")
            let name = rs.string(forColumn: "route_name")
            let direction1 = rs.string(forColumn: "direction1")
            let direction2 = rs.string(forColumn: "direction2")
            let active = rs.string(forColumn: "route_active")
            let days = rs.string(forColumn: "days_active")
            
            // TODO: Not sure if we should normalize the values here.
            var normalizedName = name?.lowercased().capitalized
            normalizedName = normalizedName?.replacingOccurrences(of: (routeID?.appending(" - "))!, with: "")
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
        
        database.close()
        
        return routes
    }

    func getStopsFor(route: Route) -> [Stop] {
        
        var stops = [Stop]()
        
        guard let routeID = route.routeID else {
            print("Error: Invalid route")
            return stops
        }
        
        guard database.open() else {
            print("Error: Database could not be opened")
            return stops
        }
        
        guard let rs = database.executeQuery("select * from 'Stops' where route_id='\(routeID)'", withArgumentsIn: nil) else {
            print("Error: Could not find any stops \(route.routeID)")
            return stops
        }
        
        while rs.next() {
            let name = rs.string(forColumn: "stop_name")
            let number = rs.string(forColumn: "stop_number")
            let direction = rs.string(forColumn: "direction")
            let latitude = rs.double(forColumn: "latitude")
            let longitude = rs.double(forColumn: "longitude")
            let active = rs.string(forColumn: "stop_active")
            
            // TODO: Not sure if we should normalize the values here.
            var normalizedName = name?.lowercased().capitalized
            normalizedName = normalizedName?.replacingOccurrences(of: "+", with: "&")
            
            let stop = Stop(name: normalizedName,
                                number: number,
                                direction: direction,
                                latitude: latitude,
                                longitude: longitude,
                                active: active == "Active")
            stops.append(stop)
        }
        
        database.close()
        
        return stops
    }
    
}
