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
        
        let DDOTRoutesDatabaseSourcePath = Bundle.main.path(forResource: "ETADetroitDatabase", ofType: "db")
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
        
        guard let rs = database.executeQuery("select * from 'routes' where company='\(company)'", withArgumentsIn: nil) else {
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
                              days: daysArray)
            routes.append(route)
        }
        
        database.close()
        
        let sortedRoutes = routes.sorted(by: { (route1, route2) -> Bool in
            
            guard let num1 = Int(route1.number!), let num2 = Int(route2.number!) else {
                return false
            }
            return num1 < num2
        })
        
        
        return sortedRoutes
    }
    
    func getStopsFor(route: Route) -> [Stop] {
        
        var stops = [Stop]()
        
        guard let company = route.company else {
            print("Error: Invalid company")
            return stops
        }
        
        guard let routeID = route.routeID else {
            print("Error: Invalid route")
            return stops
        }
        
        guard database.open() else {
            print("Error: Database could not be opened")
            return stops
        }
        guard let rs = database.executeQuery("select * from 'stop_orders' where route_id='\(routeID)' and company='\(company)'", withArgumentsIn: nil) else {
            print("Error: Could not find any stops \(route.routeID)")
            return stops
        }
        
        while rs.next() {
            let stopId = rs.string(forColumn: "stop_id")
            let name = rs.string(forColumn: "stop_name")
            let order = rs.string(forColumn: "stop_order")
            let direction = rs.string(forColumn: "direction")
            let day = rs.string(forColumn: "stop_day")
            
            let stop = Stop(routeID: routeID, stopId: stopId, name: name, order: order, direction: direction, day: day)
            stops.append(stop)
        }
        
        database.close()
        return stops
    }
    
    func getStopLocations(route: Route) -> [StopLocation] {
        
        var stopLocations = [StopLocation]()
        
        guard let company = route.company else {
            return stopLocations
        }
        guard let routeId = route.routeID else {
            return stopLocations
        }
        
        guard database.open() else {
            print("Error: Database could not be opened")
            return stopLocations
        }
        
        guard let rs = database.executeQuery("select * from stop_locations where route_id='\(routeId)' and company='\(company)'", withArgumentsIn: nil) else {
            print("Error: could not find any stops \(routeId) ")
            return stopLocations
        }
        
        while rs.next() {
            let stopID = rs.string(forColumn: "stop_id")
            let routeID = rs.string(forColumn: "route_id")
            let direction = rs.string(forColumn: "direction")
            let name = rs.string(forColumn: "stop_name")
            let latitude = Double(rs.string(forColumn: "latitude"))
            let longitude = Double(rs.string(forColumn: "longitude"))
            
            let location = StopLocation(stopID: stopID, routeID: routeID, direction: direction, name: name, latitude: latitude, longitude: longitude)
            
            stopLocations.append(location)
        }
        
        return stopLocations
    }
    
    
}
