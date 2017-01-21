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


// MARK: - Route

class Route {
    
    
    // MARK: Public
    
    var company: String?
    var routeID: String?
    var number: String?
    var name: String?
    var direction1: String?
    var direction2: String?
    var active: Bool?
    var days: Array<String>?
    
    init(company: String?, routeID: String?, number: String?, name: String?, direction1: String?, direction2: String?, active: Bool?, days: Array<String>?) {
        self.company = company
        self.routeID = routeID
        self.number = number
        self.name = name
        self.direction1 = direction1?.lowercased()
        self.direction2 = direction2?.lowercased()
        self.active = active
        self.days = days
    }
}
