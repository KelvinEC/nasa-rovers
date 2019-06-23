//
//  BBPhotoViewerPresenter.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBPhotoViewerPresenter
{
    weak var view: BBPhotoViewerProtocol?
    let photo: BBPhotoModel
    private var showingFullName: Bool = false

    init(photo: BBPhotoModel)
    {
        self.photo = photo
    }

    func viewDidLoad()
    {
        view?.show(photo: photo)
        view?.show(cameraName: photo.camera.name.rawValue.uppercased())
    }

    func closeTapped()
    {
        view?.dismiss()
    }

    func shareTapped()
    {
        view?.share(with: photo.imgSrc)
    }

    func cameraNameTapped()
    {
        showingFullName.toggle()

        if showingFullName {
            view?.show(cameraName: photo.camera.fullName.uppercased())
        } else {
            view?.show(cameraName: photo.camera.name.rawValue.uppercased())
        }
    }
}
