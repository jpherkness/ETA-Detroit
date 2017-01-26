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
    
    let kHeaderHeight: CGFloat = 300.0
    var mapView: MKMapView = {
        var mapView = MKMapView()
        var loc = mapView.centerCoordinate
        loc.latitude = 42.3314
        loc.longitude = -83.0458
        mapView.region = MKCoordinateRegionMakeWithDistance(loc, 2000, 2000)
        return mapView
    }()
    var navigationBarFooter = UIView()
    var directionSegmentControl = UISegmentedControl()
    
    // MARK: Private
    
    public var route: Route!
    public var stops = [Stop]()
    public var filteredStops = [Stop]()
    
    // MARK: UIViewController
    
    init(route: Route) {
        super.init(style: .plain)
        
        self.route = route
        stops = DatabaseManager.shared.getStopsFor(route: route)
        filterStops(direction: route.direction1!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Private
    
    private func setupViews() {
        
        title = route.name
        
        tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kHeaderHeight)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        
        navigationBarFooter.backgroundColor = navigationController?.navigationBar.barTintColor
        
        let directions = [route.direction1!.lowercased().capitalized, route.direction2!.lowercased().capitalized]
        directionSegmentControl = UISegmentedControl(items: directions)
        directionSegmentControl.selectedSegmentIndex = 0
        directionSegmentControl.tintColor = .white
        directionSegmentControl.addTarget(self, action: #selector(directionChanged(segmentedControl:)), for: .valueChanged)
        
        view.insertSubview(mapView, at: 0)
        navigationBarFooter.addSubview(directionSegmentControl)
        view.addSubview(navigationBarFooter)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        directionSegmentControl.snp.makeConstraints { make in
            make.edges.equalTo(navigationBarFooter).inset(10)
        }
        
        super.updateViewConstraints()
    }
    
    func filterStops(direction: String){
        filteredStops = stops.filter{ return $0.direction == direction }
        tableView.reloadData()
    }
}


// MARK: - UITableViewDatasource

extension StopsController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredStops[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStops.count
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
        
        let footerRect = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: 28 + 20)
        navigationBarFooter.frame = footerRect
        
        var headerRect = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: kHeaderHeight)
        if tableView.contentOffset.y < -kHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        mapView.frame = headerRect
        
    }

}


// MARK: - UISegmentControll Target

extension StopsController {
    
    func directionChanged(segmentedControl: UISegmentedControl){
        
        // TODO: Update the stops based on this selected direction
        if segmentedControl.selectedSegmentIndex == 0 {
            filterStops(direction: route.direction1!)
            print("Direction changed to:", route.direction1!)
        } else {
            filterStops(direction: route.direction2!)
            print("Direction changed to:", route.direction2!)
        }
    }
    
}
