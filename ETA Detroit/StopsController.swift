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
import GoogleMaps


// MARK: - UITableViewController

class StopsController: UITableViewController {
    
    
    // MARK: Public
    
    let kHeaderHeight: CGFloat = 300.0
    var mapView = GMSMapView()
    var menuView = UIView()
    var daySegmentControl = UISegmentedControl()
    
    var directionMenuView = UIView()
    var directionSegmentControl = UISegmentedControl()

    
    // MARK: Private
    
    public var route: Route!
    public var stops = [Stop]()
    public var filteredStops = [Stop]()
    
    public var locations = [StopLocation]()
    public var filteredLocations = [StopLocation]()
    
    public var selectedDay: String?
    public var selectedDirection: String?
    
    // MARK: UIViewController
    
    init(route: Route) {
        super.init(style: .plain)
        setRoute(route: route)
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
        
        if shouldDisplayMenuBar() {
            
            guard let days = route.days else {
                return
            }
            
            menuView.backgroundColor = navigationController?.navigationBar.barTintColor
            
            daySegmentControl = UISegmentedControl(items: days)
            daySegmentControl.selectedSegmentIndex = 0
            daySegmentControl.tintColor = .white
            daySegmentControl.addTarget(self, action: #selector(dayChanged(segmentedControl:)), for: .valueChanged)
            menuView.addSubview(daySegmentControl)
            view.addSubview(menuView)
        }
        
        if let direction1 = route.direction1, let direction2 = route.direction2 {
            directionSegmentControl = UISegmentedControl(items: [direction1, direction2])
            directionSegmentControl.tintColor = navigationController?.navigationBar.barTintColor
            directionSegmentControl.selectedSegmentIndex = 0
            directionSegmentControl.addTarget(self, action: #selector(directionChanged(segmentedControl:)), for: .valueChanged)
        }
        directionMenuView.addSubview(directionSegmentControl)
        directionMenuView.backgroundColor = .white
        
        tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kHeaderHeight)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.separatorInset = .zero
        
        view.insertSubview(mapView, at: 0)
        view.addSubview(directionMenuView)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if shouldDisplayMenuBar() {
            daySegmentControl.snp.makeConstraints { make in
                make.edges.equalTo(menuView).inset(10)
            }
        }
        
        directionSegmentControl.snp.makeConstraints { make in
            make.edges.equalTo(directionMenuView).inset(10)
        }
        super.updateViewConstraints()
    }
    
    func filterStops(){
        
        // Start with a non filtered array
        filteredStops = stops
        
        // If the day is not null, filter the stops by day
        if let selectedDay = selectedDay {
            filteredStops = filteredStops.filter { $0.day! == selectedDay }
        }
        
        // If the direction is not null, filter the stops by direction
        if let selectedDirection = selectedDirection {
            filteredStops = filteredStops.filter { $0.direction! == selectedDirection }
        }
        
        // Reload the tableView
        tableView.reloadData()
    }
    
    func filterLocations(){
        
        // Start with a non filtered array
        filteredLocations = locations
        
        // If the direction is not null, filter the stops by direction
        if let selectedDirection = selectedDirection {
            filteredLocations = filteredLocations.filter { $0.direction!.lowercased() == selectedDirection.lowercased() }
        }
        
        // Reload the tableView
        updateMapRoute()
    }
    
    func setRoute(route: Route){
        self.route = route
        stops = DatabaseManager.shared.getStopsFor(route: route)
        locations = DatabaseManager.shared.getStopLocations(route: route)
        
        selectedDay = route.days?.first
        selectedDirection = route.direction1
        filterStops()
        filterLocations()
    }
    
    func shouldDisplayMenuBar() -> Bool {
        guard let days = route.days else {
            return false
        }
        
        if days.count < 1 {
            return false
        }
        return days[0] != "Everyday"
    }
    
    func updateMapRoute(){
    }
}



// MARK: - UITableViewDatasource

extension StopsController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredStops[indexPath.row].name!.lowercased().capitalized
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - UIScrollViewDelegate

extension StopsController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Position the menu view inside the scrollview
        if shouldDisplayMenuBar() {
            let menuRect = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: 28 + 20)
            menuView.frame = menuRect
        }
        
        // Position the map inside the scrollview
        var mapRect = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: kHeaderHeight)
        if tableView.contentOffset.y < -kHeaderHeight {
            mapRect.origin.y = tableView.contentOffset.y
            mapRect.size.height = -tableView.contentOffset.y
        }
        
        mapView.frame = mapRect
        
        var directionMenuRect = CGRect(x: 0, y: -48, width: tableView.bounds.width, height: 28 + 20)
        if tableView.contentOffset.y > -96 && shouldDisplayMenuBar() {
            directionMenuRect.origin.y = tableView.contentOffset.y + 48
        } else if tableView.contentOffset.y > -48 {
            directionMenuRect.origin.y = tableView.contentOffset.y
        }
        directionMenuView.frame = directionMenuRect
    }

}


// MARK: - UISegmentControll Target

extension StopsController {
    
    func dayChanged(segmentedControl: UISegmentedControl){
        
        // Return if the days array is null
        guard let days = route.days else{
            return
        }
        
        // Update the selected day and filter the stops
        selectedDay = days[segmentedControl.selectedSegmentIndex]
        filterStops()
        filterLocations()
    }
    func directionChanged(segmentedControl: UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0 {
            selectedDirection = route.direction1
        }else{
            selectedDirection = route.direction2
        }
        filterStops()
        filterLocations()
    }
    
}
