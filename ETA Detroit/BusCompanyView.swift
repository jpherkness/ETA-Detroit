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


// MARK: - BusCompanyView

class BusCompanyView: UIView {
    
    
    // MARK: Private
    
    private var busImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var busNameLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        return label
    }()
    
    private var cover = UIView()
    
    
    // MARK: UIViewController
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(busImageView)
        addSubview(cover)
        addSubview(busNameLabel)
        cover.layer.opacity = 0.3
        
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
        
        cover.snp.makeConstraints {make in
            make.edges.equalTo(busImageView)
        }
        super.updateConstraints()
    }
    
    
    // MARK: Public
    
    func configure(image: UIImage, text: String, brandColor: UIColor) {
        busNameLabel.text = text
        busImageView.image = image
        busNameLabel.backgroundColor = brandColor
        cover.backgroundColor = brandColor
    }
}
