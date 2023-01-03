//
//  PlayerTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/20/22.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTeam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:TeamPlayerData?,team:TeamInfoData?){
        imgPlayer.setImage(with: obj?.photo, placeholder: Utility.getPlaceHolder())
        imgLogo.setImage(with: team?.logo, placeholder: Utility.getPlaceHolder())
        lblName.text = obj?.nameEn
        lblTeam.text = team?.nameEn
        if Utility.getCurrentLang() == "cn"{
            lblName.text = obj?.nameChs
            lblTeam.text = team?.nameChs
        }
        lblValue.text = "$\(obj?.value ?? "") \("Million".localized)"
        
    }
    
}
