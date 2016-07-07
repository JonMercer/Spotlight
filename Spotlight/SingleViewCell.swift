//
//  SingleViewCell.swift
//  Spotlight
//
//  Created by YK Sugishita on 7/5/16.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class SingleViewCell: UITableViewCell {
    @IBOutlet weak var singleListIV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        singleListIV.image = UIImage(named: "100by100")!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
