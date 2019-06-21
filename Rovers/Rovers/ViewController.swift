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
        let getRoverManifest = BBGetRoverManifest(roverManifestNetworking: manifest)
        let getRoverPhotos = BBGetRoverPhotos(roverPhotosNetworking: roverPhotos)

        getRoverManifest.getManifest(for: .curiosity) { result in
            switch result {
            case .success(let manifest):
                if let mWrapped = manifest {
                    print(mWrapped.maxDate)
                    getRoverPhotos.get(for: .curiosity, date: mWrapped.maxDate) { result in
                        switch result {
                        case .success(let photos):
                            if let pWrapped = photos {
                                print(pWrapped.map({$0.earthDate}))
                            }
                        case .failure(let err): print(err)
                        }
                    }
                }
            case .failure(let err): print(err)
            }
        }
    }
}

