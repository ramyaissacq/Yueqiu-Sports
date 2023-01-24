//
//  LeagueCollectionViewCell.swift
//  Excellence Sports
//
//  Created by Remya on 1/13/23.
//

import UIKit

class LeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblLeague: UILabel!
    @IBOutlet weak var lblSeason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(obj:FootballLeague?){
        lblLeague.text = obj?.name
        imgLogo.image = UIImage(named: obj!.image!)
    }
    
    func configureCell(obj:SeasonData?){
        lblLeague.text = obj?.name
        imgLogo.setImage(with: obj?.leagueLogo, placeholder: Utility.getPlaceHolder())
        lblSeason.text = "\(obj?.yearStart ?? "") - \(obj?.yearEnd ?? "")"
    }
    
    

}
