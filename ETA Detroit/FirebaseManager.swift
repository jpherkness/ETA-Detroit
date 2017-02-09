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
        
//        print(ref.url)
//        ref.child("routes").observeSingleEvent(of: .value, with: { snapshot in
//            for child in snapshot.children.allObjects {
//                print(child)
//            }
//        })
        
        return [Route]()
    }
    
    func getStopsFor(route: Route) -> [Stop] {
        return [Stop]()
    }
    
    func getStopLocationsFor(route: Route) -> [StopLocation] {
        return [StopLocation]()
    }
}
