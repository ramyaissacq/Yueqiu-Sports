//
//  TeamHeaderTableViewCell.swift
//  Excellence Sports
//
//  Created by Remya on 1/16/23.
//

import UIKit

class TeamHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var imgTeamLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
