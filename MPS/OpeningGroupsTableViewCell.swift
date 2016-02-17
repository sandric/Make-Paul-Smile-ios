//
//  OpeningGroupsTableViewCell.swift
//  MPS
//
//  Created by sandric on 18.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class OpeningGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet var openingGroupLabel: UILabel!
    
    @IBOutlet var trainButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
