//
//  DataListTableViewCell.swift
//  SQLiteLibrary
//
//  Created by 王 on 2017/07/09.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import UIKit

class DataListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamIdLabel: UILabel!
    @IBOutlet weak var teamCityLabel: UILabel!
    @IBOutlet weak var teamNickNameLabel: UILabel!
    @IBOutlet weak var teamAbbreviationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
