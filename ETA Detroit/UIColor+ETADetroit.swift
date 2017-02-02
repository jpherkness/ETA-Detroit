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

import UIKit


// MARK: - UIColor+ETADetroit

extension UIColor {
    
    class func etadTintColor() -> UIColor {
        return UIColor(red:0.15, green:0.60, blue:0.46, alpha:1.00)
    }
    
    class func etadRouteNumberLabelColor() -> UIColor {
        return UIColor(red:0.44, green:0.71, blue:0.95, alpha:1.00)
    }
    
    class func etadSmartBrandColor() -> UIColor {
        return UIColor(red:0.94, green:0.25, blue:0.24, alpha:1.00)
    }
    
    class func etadDdotBrandColor() -> UIColor {
        return UIColor(red:0.02, green:0.28, blue:0.22, alpha:1.00)
    }
    
    class func etadReflexBrandColor() -> UIColor {
        return UIColor(red:0.17, green:0.39, blue:0.82, alpha:1.00)
    }
    
}
