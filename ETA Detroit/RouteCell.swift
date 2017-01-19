//
//  RouteCell.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/19/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell {
    
    let routeLabel: UILabel = {
        var label = UILabel()
        label.text = "ROUTE"
        label.textColor = Color.routeLabelColor
        label.adjustsFontSizeToFitWidth = true
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        return label
    }()
    
    let routeNumberLabel: UILabel = {
        var label = UILabel()
        label.textColor = Color.routeLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let routeNameLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareCell()
    }
    
    func prepareCell() {
        addSubview(routeLabel)
        addSubview(routeNumberLabel)
        addSubview(routeNameLabel)
        
        setNeedsUpdateConstraints()
    }
    
    func configureCell(route: Route) {
        guard let name = route.name, let number = route.number else {
            return
        }
        routeNameLabel.text = name
        routeNumberLabel.text = number
    }
    
    override func updateConstraints() {
        routeLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(routeNumberLabel.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        routeNumberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(5)
            make.left.equalTo(self)
            make.top.equalTo(routeLabel.snp.bottom)
            make.width.equalTo(60)
        }
        
        routeNameLabel.snp.makeConstraints { make in
            make.left.equalTo(routeLabel.snp.right)
            make.right.top.bottom.equalTo(self)
        }
        
        super.updateConstraints()
    }

}
