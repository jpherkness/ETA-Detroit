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


// MARK: - RouteCell

class RouteCell: UITableViewCell {
    
    
    // MARK: Private
    
    private let routeLabel: UILabel = {
        var label = UILabel()
        label.text = "ROUTE"
        label.textColor = Color.routeLabelColor
        label.adjustsFontSizeToFitWidth = true
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        return label
    }()
    
    private let routeNumberLabel: UILabel = {
        var label = UILabel()
        label.textColor = Color.routeLabelColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private let routeNameLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    private let leftBox = UIView()
    
    
    // Mark: UITableViewCell
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareCell()
    }
    
    override func updateConstraints() {
        
        leftBox.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(60)
        }
        
        routeLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(leftBox)
            make.bottom.equalTo(leftBox.snp.centerY)
        }
        
        routeNumberLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(leftBox)
            make.top.equalTo(leftBox.snp.centerY)
        }
        
        routeNameLabel.snp.makeConstraints { make in
            make.left.equalTo(leftBox.snp.right)
            make.right.top.bottom.equalTo(self)
        }
        
        super.updateConstraints()
    }
    
    
    // MARK: Public
    
    func prepareCell() {
        leftBox.addSubview(routeLabel)
        leftBox.addSubview(routeNumberLabel)
        addSubview(leftBox)
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

}
