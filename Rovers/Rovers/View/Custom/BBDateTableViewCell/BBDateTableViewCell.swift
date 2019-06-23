//
//  BBDateTableViewCell.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBDateTableViewCell: UITableViewCell
{
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        setSelected(false, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        accessoryType = selected ? .checkmark : .none
    }
}
