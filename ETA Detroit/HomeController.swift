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

import SnapKit


// MARK: - HomeController

class HomeController: UIViewController {
    
    
    // MARK: Private
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let button: UIButton = {
        var button = UIButton()
        button.setTitle("PLAN MY ROUTE", for: .normal)
        button.backgroundColor = .etadTintColor()
        button.addTarget(self, action: #selector(selectedPlanMyRoute), for: .touchUpInside)
        return button
    }()
    
    private lazy var smartBusCompanyView: BusSelectionView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedSmart))
        let busSelectionView = BusSelectionView(image: #imageLiteral(resourceName: "smart-bus"), text: "VIEW SMART SCHEDULE", brandColor: UIColor.etadSmartBrandColor())
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    private lazy var ddotBusCompanyView: BusSelectionView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedDDOT))
        let busSelectionView = BusSelectionView(image: #imageLiteral(resourceName: "ddot-bus"), text: "VIEW DDOT SCHEDULE", brandColor: UIColor.etadDdotBrandColor())
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    private lazy var reflexBusCompanyView: BusSelectionView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedReflex))
        let busSelectionView = BusSelectionView(image: #imageLiteral(resourceName: "reflex-bus"), text: "VIEW REFLEX SCHEDULE", brandColor: UIColor.etadReflexBrandColor())
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else {
            return
        }
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = UIColor.etadTintColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(40)
        }
        
        smartBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        ddotBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(smartBusCompanyView.snp.bottom).offset(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        reflexBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(ddotBusCompanyView.snp.bottom).offset(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.bottom.equalTo(-10)
            make.height.equalTo(160)
        }
        
        super.updateViewConstraints()
    }
    
    
    // MARK: Public
    
    func setupViews() {
        title = "ETA Detroit"
        view.backgroundColor = .white
        scrollView.addSubview(button)
        scrollView.addSubview(smartBusCompanyView)
        scrollView.addSubview(ddotBusCompanyView)
        scrollView.addSubview(reflexBusCompanyView)
        view.addSubview(scrollView)
    }
    
    
    // MARK: Selectors
    
    private dynamic func selectedPlanMyRoute() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    private dynamic func selectedSmart() {
        navigationController?.pushViewController(SmartRoutesController(), animated: true)
    }
    
    private dynamic func selectedDDOT() {
        navigationController?.pushViewController(DdotRoutesController(), animated: true)
    }
    
    private dynamic func selectedReflex() {
        navigationController?.pushViewController(ReflexRoutesController(), animated: true)
    }
    
}

