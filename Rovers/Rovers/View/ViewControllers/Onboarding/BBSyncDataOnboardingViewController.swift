//
//  BBSyncDataOnboardingViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBSyncDataOnboardingViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var roversHelloLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var syncDataButton: UIButton!

    // MARK: - Class Properties
    var eventHandler: BBSyncDataPresenter!

    // MARK: - View Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTexts()
    }

    // MARK: - View Private Methods
    func setupTexts()
    {
        roversHelloLabel.text = NSLocalizedString("Hello from Curiosity, Opportunity and Spirit!", comment: "")
        descriptionLabel.text = NSLocalizedString("""
Hey, we are your fellows on this travel!

In order to show what we caught during the missions, we need to sync data with NASA servers. If it's not your first time here, you will see a button to continue without update!

If you will enjoy the pictures, feel free to share with your friends!
""", comment: "")

        syncDataButton.setTitle(NSLocalizedString("Sync Data", comment: ""), for: .normal)
    }

    // MARK: - IBActions

    @IBAction func syncDataTapped(_ sender: Any)
    {
        eventHandler.syncDataTapped()
    }
}
