//
//  UIImageViewExtensions.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView
{
    func setImage(with imageURL: URL, placeholder: UIImage?)
    {
        let processor = DownsamplingImageProcessor(size: self.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 8)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL, placeholder: placeholder,
                         options: [.processor(processor),
                                   .scaleFactor(UIScreen.main.scale),
                                   .transition(.fade(0.3)),
                                   .cacheOriginalImage])
    }
}
