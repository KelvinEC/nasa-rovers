//
//  BBFilterByDateViewController.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBFilterByDateViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var datesTableView: UITableView!

    // MARK: - Properties
    private let dateCellIdentifier = "BBDateCell"
    private var _dates: [String] = [String]()
    private var _selectedDate: String?

    var eventHandler: BBFilterByDatePresenter!

    // MARK: - View Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.title = "Filter By Earth Date"

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        definesPresentationContext = true

        datesTableView.register(UINib(nibName: dateCellIdentifier,
                                      bundle: Bundle.main),
                                forCellReuseIdentifier: dateCellIdentifier)
        datesTableView.delegate = self
        datesTableView.dataSource = self

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset", comment: ""),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(resetTapped))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Apply", comment: ""),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(applyTapped))

        eventHandler.viewDidLoad()
    }

    // MARK: - IBActions
    @objc func applyTapped()
    {
        eventHandler.applyTapped()
    }

    @objc func resetTapped()
    {
        eventHandler.resetTapped()
    }
}

extension BBFilterByDateViewController: BBFilterByDateViewProtocol
{
    func show(dates: [String], selected: String?)
    {
        _selectedDate = selected
        _dates.removeAll()
        _dates.append(contentsOf: dates)
    }

    func reloadData()
    {
        datesTableView.reloadData()
    }

    func dismiss()
    {
        dismiss(animated: true, completion: nil)
    }
}

extension BBFilterByDateViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        eventHandler.search(criteria: searchController.searchBar.text)
    }
}

extension BBFilterByDateViewController: UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        eventHandler.search(criteria: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        eventHandler.search(criteria: searchBar.text)
    }
}

extension BBFilterByDateViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier,
                                                    for: indexPath) as? BBDateTableViewCell {
            cell.dateLabel.text = _dates[indexPath.row]
            cell.selectionStyle = .none

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if let sel = _selectedDate, sel == _dates[indexPath.row] {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}

extension BBFilterByDateViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        eventHandler.didSelectedFilter(_dates[indexPath.row])
    }
}
