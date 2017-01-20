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


// MARK: - ViewController

class ViewController: UIViewController {
    
    
    // MARK: Private
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let button: UIButton = {
        var button = UIButton()
        button.setTitle("PLAN MY ROUTE", for: .normal)
        button.backgroundColor = Color.primary
        button.addTarget(self, action: #selector(selectedPlanMyRoute), for: .touchUpInside)
        return button
    }()
    
    private lazy var smartBusCompanyView: BusCompanyView = {
        let busCompanyView = BusCompanyView()
        busCompanyView.configure(image: UIImage(named: "Smart-Bus.png")!,
                                 text: "VIEW SMART SCHEDULE",
                                 brandColor: Color.smartBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedSmart))
        busCompanyView.addGestureRecognizer(tap)
        return busCompanyView
    }()
    
    private lazy var ddotBusCompanyView: BusCompanyView = {
        let busCompanyView = BusCompanyView()
        busCompanyView.configure(image: UIImage(named: "ddot-Bus.png")!,
                                 text: "VIEW DDOT SCHEDULE",
                                 brandColor: Color.ddotBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedDDOT))
        busCompanyView.addGestureRecognizer(tap)
        return busCompanyView
    }()
    
    private lazy var reflexBusCompanyView: BusCompanyView = {
        let busCompanyView = BusCompanyView()
        busCompanyView.configure(image: UIImage(named: "Reflex-Bus.png")!,
                                 text: "VIEW REFLEX SCHEDULE",
                                 brandColor: Color.reflexBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedReflex))
        busCompanyView.addGestureRecognizer(tap)
        return busCompanyView
    }()
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.width.equalTo(scrollView).inset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(40)
        }
        
        smartBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.width.equalTo(scrollView).inset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        ddotBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(smartBusCompanyView.snp.bottom).offset(5)
            make.width.equalTo(scrollView).inset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        reflexBusCompanyView.snp.makeConstraints { make in
            make.top.equalTo(ddotBusCompanyView.snp.bottom).offset(5)
            make.width.equalTo(scrollView).inset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.bottom.equalTo(-20)
            make.height.equalTo(160)
        }
        
        super.updateViewConstraints()
    }
    
    
    // MARK: Public
    
    func prepare() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = Color.primary
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "ETA Detroit"
        scrollView.alwaysBounceVertical = true
        scrollView.addSubview(button)
        scrollView.addSubview(smartBusCompanyView)
        scrollView.addSubview(ddotBusCompanyView)
        scrollView.addSubview(reflexBusCompanyView)
        view.addSubview(scrollView)
    }
    
    
    // MARK: Internal
    
    private dynamic func selectedPlanMyRoute() {}
    
    private dynamic func selectedSmart() {
        navigationController?.pushViewController(SmartRoutesController(), animated: true)
    }
    
    private dynamic func selectedDDOT() {
        navigationController?.pushViewController(DDOTRoutesController(), animated: true)
    }
    
    private dynamic func selectedReflex() {}
    
}

