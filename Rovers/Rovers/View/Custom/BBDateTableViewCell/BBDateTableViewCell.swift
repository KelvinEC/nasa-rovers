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
    @IBOutlet weak var checkmarkImageView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        setSelected(false, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        if selected {
            self.checkmarkImageView.alpha = 0.0
            self.checkmarkImageView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.checkmarkImageView.alpha = 1.0
            }
        } else {
            self.checkmarkImageView.alpha = 1.0
            self.checkmarkImageView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.checkmarkImageView.alpha = 1.0
            }, completion: { _ in
                self.checkmarkImageView.isHidden = true
            })
        }
    }
}
