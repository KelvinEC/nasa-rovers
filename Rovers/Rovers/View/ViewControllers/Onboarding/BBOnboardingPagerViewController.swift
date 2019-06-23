//
//  BBOnboardingPagerViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBOnboardingPagerViewController: UIPageViewController
{
    var pages: [UIViewController]!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.view.backgroundColor = UIColor.white
        self.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension BBOnboardingPagerViewController: UIPageViewControllerDataSource
{
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else {
            return nil
        }

        return pages[nextIndex]
    }
}
