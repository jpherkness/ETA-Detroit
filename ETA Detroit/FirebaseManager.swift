//
//  FirebaseManager.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 2/2/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseManager: DatabaseManager {
    
    static var sharedInstance = FirebaseManager()
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
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
        
        print(ref.url)
        ref.child("routes").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects {
                print(child)
            }
        })
        
        return [Route]()
    }
    
    func getStopsFor(route: Route) -> [Stop] {
        return [Stop]()
    }
    
    func getStopLocations(route: Route) -> [StopLocation] {
        return [StopLocation]()
    }
}
