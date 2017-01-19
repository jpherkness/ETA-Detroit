//
//  ViewController.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/17/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let button: UIButton = {
        var button = UIButton()
        button.setTitle("PLAN MY ROUTE", for: .normal)
        button.backgroundColor = Color.primary
        button.addTarget(self, action: #selector(selectedPlanMyRoute), for: .touchUpInside)
        return button
    }()
    
    lazy var smart: CompanyView = {
        let busSelectionView = CompanyView()
        busSelectionView.configure(busImage: UIImage(named: "smart.jpg")!,
                                   busName: "VIEW SMART SCHEDULE",
                                   brandColor: Color.smartBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedSmart))
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    lazy var ddot: CompanyView = {
        let busSelectionView = CompanyView()
        busSelectionView.configure(busImage: UIImage(named: "ddot.jpg")!,
                                   busName: "VIEW DDOT SCHEDULE",
                                   brandColor: Color.ddotBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedDDOT))
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    lazy var reflex: CompanyView = {
        let busSelectionView = CompanyView()
        busSelectionView.configure(busImage: UIImage(named: "reflex.jpg")!,
                                   busName: "VIEW REFLEX SCHEDULE",
                                   brandColor: Color.reflexBrandColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedReflex))
        busSelectionView.addGestureRecognizer(tap)
        return busSelectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = Color.primary
    }
    
    func prepare() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = Color.primary
        title = "ETADetroit"
        scrollView.alwaysBounceVertical = true
        scrollView.addSubview(button)
        scrollView.addSubview(smart)
        scrollView.addSubview(ddot)
        scrollView.addSubview(reflex)
        view.addSubview(scrollView)
    }
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(40)
        }
        
        smart.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        ddot.snp.makeConstraints { make in
            make.top.equalTo(smart.snp.bottom).offset(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(160)
        }
        
        reflex.snp.makeConstraints { make in
            make.top.equalTo(ddot.snp.bottom).offset(10)
            make.width.equalTo(scrollView).inset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.bottom.equalTo(-10)
            make.height.equalTo(160)
        }
        
        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectedPlanMyRoute() {
        print("Selected Plan My Route")
    }
    
    func selectedSmart() {
        navigationController?.pushViewController(SmartBusRoutesController(), animated: true)
    }
    
    func selectedDDOT() {
        navigationController?.pushViewController(DDOTRoutesController(), animated: true)
    }
    
    func selectedReflex() {
        print("Selected Reflex")
    }
    
}

