//
//  ViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let manifest = BBManifestsNetworking(BBNetworking.shared)
        let roverPhotos = BBRoversPhotosNetworking(BBNetworking.shared)

        manifest.getRoverManifest(rover: .curiosity) { result in
            switch result {
            case .success(let manifest):
                if let maxDate = manifest?.photoManifest.maxDate {
                    print(maxDate)
                    roverPhotos.getRoverManifest(rover: .curiosity, date: maxDate) { result in
                        switch result {
                        case .success(let photosMetadata):
                            print(photosMetadata?.photos.map({$0.camera}) ?? "")
                        case .failure(let e):
                            print(e)
                        }
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

