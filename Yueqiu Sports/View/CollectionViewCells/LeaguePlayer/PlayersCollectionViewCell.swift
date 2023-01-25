//
//  PlayersCollectionViewCell.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import UIKit

class PlayersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(obj:PlayerDetailsData?){
        playerName.text = obj?.name
        playerImage.setImage(with: obj?.photo, placeholder: Utility.getPlaceHolder())

    }

}
