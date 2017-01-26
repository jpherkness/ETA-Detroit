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


// MARK: - BusSelectionView

class BusSelectionView: UIView {
    
    
    // MARK: Private
    
    private var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(white: 0, alpha: 0.0)
        label.textColor = .white
        return label
    }()
    
    
    // MARK: UIViewController
    
    convenience init(image: UIImage, text: String, brandColor: UIColor) {
        self.init()
        textLabel.text = text
        textLabel.backgroundColor = brandColor
        imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(textLabel.snp.top)
        }
        
        textLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(50)
        }
        
        super.updateConstraints()
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(textLabel)
    }
}
