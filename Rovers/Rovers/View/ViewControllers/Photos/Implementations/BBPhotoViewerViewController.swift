//
//  BBPhotoViewerViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import Kingfisher

class BBPhotoViewerViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var cameraNameBackgroundView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!

    // MARK: - Class Properties
    var eventHandler: BBPhotoViewerPresenter!

    // MARK: - View Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.toolbar.setBackgroundImage(UIImage(),
                                        forToolbarPosition: .any,
                                        barMetrics: .default)
        self.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCameraName(_:)))
        cameraNameBackgroundView.addGestureRecognizer(tapGesture)

        imageScrollView.delegate = self

        photoImageView.backgroundColor = UIColor.clear

        eventHandler.viewDidLoad()
    }

    @IBAction func closeTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func shareTapped(_ sender: Any)
    {
        eventHandler.shareTapped()
    }

    @objc func tappedCameraName(_ sender: Any)
    {
        eventHandler.cameraNameTapped()
    }
}

extension BBPhotoViewerViewController: BBPhotoViewerProtocol
{
    func show(photo: BBPhotoModel)
    {
        if let url = URL(string: photo.imgSrc) {
            photoImageView.setImage(with: url, placeholder: nil)
        }
    }

    func show(cameraName: String)
    {
        cameraNameLabel.text = cameraName.uppercased()
    }

    func share(with imageSrc: String)
    {
        if let url = URL(string: imageSrc) {
            BBImageCache.getImage(url) { result in
                switch result {
                case .success(let img):
                    let imageToShare = [img]
                    let activityViewController = UIActivityViewController(activityItems: imageToShare,
                                                                          applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                    self.present(activityViewController, animated: true, completion: nil)
                case .failure:
                    self.showError(title: NSLocalizedString("Error", comment: ""),
                                   description: NSLocalizedString("Failed to get Image to share." +
                                    " Please, try again", comment: ""))
                }
            }
        }
    }

    func dismiss()
    {
        dismiss(animated: true, completion: nil)
    }
}

extension BBPhotoViewerViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return photoImageView
    }
}
