//
//  BBWelcomeOnboardingViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBWelcomeOnboardingViewController: UIViewController
{
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTexts()
    }

    func setupTexts()
    {
        welcomeLabel.text = NSLocalizedString("Welcome, astronaut!", comment: "")
        descriptionLabel.text = NSLocalizedString("Here you will travel around Mars with pictures taken by Rovers during the last years. HAVE FUN!", comment: "")
    }
}
