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
import MapKit


// MARK: - UITableViewController

class StopsController: UITableViewController {
    
    
    // MARK: Public
    
    let kHeaderHeight: CGFloat = 200.0
    var mapView: MKMapView!
    
    
    // MARK: Private
    
    private var route: Route!
    public var stops = [Stop]()
    
    
    // MARK: UIViewController
    
    init(route: Route, style: UITableViewStyle) {
        super.init(style: style)
        
        self.route = route
        
        prepare()
        loadStops()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Private
    
    func prepare() {
        mapView = MKMapView()
        view.insertSubview(mapView, at: 0)
        
        tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kHeaderHeight)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        
        title = route.name
    }
    
    func loadStops() {
        stops = DatabaseManager.shared.getDDOTStopsFor(route: route)
    }
    
}


// MARK: - UITableViewDatasource

extension StopsController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = stops[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


// MARL: - UITableViewDelegate

extension StopsController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}


// MARK: - UIScrollViewDelegate

extension StopsController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var headerRect = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: kHeaderHeight)
        if tableView.contentOffset.y < -kHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        mapView.frame = headerRect
    }

}
