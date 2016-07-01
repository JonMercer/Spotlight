//
//  SpotCell.swift
//  Spotlight
//
//  Created by Yosuke Sugishita on 6/30/16.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class SpotCell: UITableViewCell {

    @IBOutlet weak var spotImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        spotImageView.image = UIImage(named: "350")!
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
