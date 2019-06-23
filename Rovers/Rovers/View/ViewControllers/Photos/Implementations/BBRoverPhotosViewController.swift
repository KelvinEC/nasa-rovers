//
//  ViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import Kingfisher

class BBRoverPhotosViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var roverPhotosCollectionView: UICollectionView!
    @IBOutlet weak var roversSegmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedToolbar: UIToolbar!

    // MARK: - View Properties
    private var photos: [BBPhotoModel] = [BBPhotoModel]()
    var eventHandler: BBRoverPhotosPresenter!

    let roverPhotosCellIdentifier = "BBPhotoCollectionViewCell"

    // MARK: - UIView Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Mars Rovers Photos"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "calendar"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(filterByDateTapped))
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.segmentedToolbar.backgroundColor = UIColor.white
        self.segmentedToolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        roverPhotosCollectionView.register(UINib(nibName: roverPhotosCellIdentifier,
                                                 bundle: Bundle.main),
                                           forCellWithReuseIdentifier: roverPhotosCellIdentifier)

        roverPhotosCollectionView.delegate = self
        roverPhotosCollectionView.dataSource = self
        roverPhotosCollectionView.prefetchDataSource = self

        eventHandler.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func roverChanged(_ sender: UISegmentedControl)
    {
        eventHandler.selectedRoverChanged(sender.selectedSegmentIndex)
    }

    @objc func filterByDateTapped()
    {
        eventHandler.filterByDateTapped()
    }
}

extension BBRoverPhotosViewController: BBRoverPhotosViewProtocol
{
    func show(rovers: [String])
    {
        roversSegmentedControl.removeAllSegments()
        for i in 0 ..< rovers.count {
            roversSegmentedControl.insertSegment(withTitle: rovers[i], at: i, animated: false)
        }

        roversSegmentedControl.selectedSegmentIndex = 0
    }

    func show(photos: [BBPhotoModel])
    {
        self.photos.removeAll()
        self.photos.append(contentsOf: photos)
    }

    func reloadData()
    {
        self.roverPhotosCollectionView.reloadData()
    }

    func appendPhotos(photos: [BBPhotoModel])
    {
        self.photos.append(contentsOf: photos)
    }

    func insert(numberOf rows: Int)
    {
        let currentNumberOfItems = roverPhotosCollectionView.numberOfItems(inSection: 0)
        var indexPaths = [IndexPath]()
        for i in  currentNumberOfItems ..< currentNumberOfItems + rows {
            indexPaths.append(IndexPath(row: i, section: 0))
        }

        roverPhotosCollectionView.insertItems(at: indexPaths)
    }

    func showNoFiltersAvailableError()
    {
        showError(title: NSLocalizedString("Error", comment: ""),
                  description: NSLocalizedString("Theres no filter availables for this Rover :/", comment: ""))
    }
}

extension BBRoverPhotosViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        eventHandler.selectedRoverPhoto(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roverPhotosCellIdentifier,
                                                         for: indexPath) as? BBPhotoCollectionViewCell {
            let photo = photos[indexPath.row]

            if let photoURL = URL(string: photo.imgSrc) {
                cell.imageView.setImage(with: photoURL, placeholder: nil)
            }

            return cell
        }

        return UICollectionViewCell()
    }
}

extension BBRoverPhotosViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let pictureSize = (UIScreen.main.bounds.width / 2) - 10
        return CGSize(width: pictureSize, height: pictureSize)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath)
    {
        eventHandler.willShow(indexPath.row)
    }
}

extension BBRoverPhotosViewController: UICollectionViewDataSourcePrefetching
{
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath])
    {
        var urls: [URL] = [URL]()

        indexPaths.forEach { index in
            if let url = URL(string: photos[index.row].imgSrc) {
                urls.append(url)
            }
        }

        BBImageCache.prefetchImage(urls)
    }
}
