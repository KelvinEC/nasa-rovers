//
//  BBPhotoViewerProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBPhotoViewerProtocol: AnyObject
{
    func show(photo: BBPhotoModel)

    func show(cameraName: String)

    func share(with imageSrc: String)

    func dismiss()
}
