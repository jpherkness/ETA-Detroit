//
//  BusSelectionView.swift
//  ETA Detroit
//
//  Created by Joseph Herkness on 1/17/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class CompanyView: UIView {
    
    var busImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var busNameLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        return label
    }()
    
    func prepareView() {
        addSubview(busImageView)
        addSubview(busNameLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(busImageView)
        addSubview(busNameLabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        busImageView.snp.makeConstraints { make in
            make.top.right.left.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        busNameLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.right.left.bottom.equalTo(self).inset(UIEdgeInsets.zero)
        }
        super.updateConstraints()
    }
    
    func configure(busImage: UIImage, busName: String, brandColor: UIColor) {
        busNameLabel.text = busName
        busImageView.image = busImage
        busNameLabel.backgroundColor = brandColor
    }
}
