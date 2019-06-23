//
//  BBFilterByDatePresenter.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBFilterByDateProtocol: AnyObject
{
    func selected(filter: String?)
}

class BBFilterByDatePresenter
{
    weak var view: BBFilterByDateViewProtocol?
    private weak var _delegate: BBFilterByDateProtocol?
    private var _datesAvailable: [BBDateFilter]
    private var _filteredDates: [BBDateFilter] = [BBDateFilter]()
    private var _selectedFilter: String?

    init(_ datesAvailable: [BBDateFilter],
         selectedValue: BBDateFilter,
         delegate: BBFilterByDateProtocol)
    {
        _selectedFilter = selectedValue.userDate
        _delegate = delegate
        _datesAvailable = datesAvailable
        _filteredDates.append(contentsOf: _datesAvailable)

        _datesAvailable.sort { f, s in
            f.date.compare(s.date) == .orderedDescending
        }
    }

    func viewDidLoad()
    {
        search(criteria: nil)
    }

    func search(criteria: String?)
    {
        _filteredDates.removeAll()

        if let query = criteria, !query.isEmpty {
            _filteredDates = _datesAvailable.filter {
                $0.serverDate.lowercased().contains(query.lowercased()) ||
                    $0.userDate.lowercased().contains(query.lowercased())
            }
        } else {
            _filteredDates.append(contentsOf: _datesAvailable)
        }

        view?.show(dates: _filteredDates.map({$0.userDate}),
                   selected: _selectedFilter)
        view?.reloadData()
    }

    func applyTapped()
    {
        if let filter = _selectedFilter, let filterDate = _filteredDates.first(where: {$0.userDate == filter}) {
            _delegate?.selected(filter: filterDate.serverDate)
        }

        view?.dismiss()
    }

    func resetTapped()
    {
        _delegate?.selected(filter: nil)
        view?.dismiss()
    }

    func didSelectedFilter(_ filter: String)
    {
        _selectedFilter = filter
    }
}
