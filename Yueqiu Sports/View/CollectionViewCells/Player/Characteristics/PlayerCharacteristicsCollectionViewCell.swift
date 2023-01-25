//
//  PlayerCharacteristicsCollectionViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class PlayerCharacteristicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var stack: UIStackView!
    
    var callSelection:(()->Void)?
//    var underLineColor:UIColor?{
//        didSet{
//            underLineView.backgroundColor = underLineColor
//        }
//    }
    
    var titleColor:UIColor?{
        didSet{
            lblTitle.textColor = .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
          handleSelection()
        }
        
    }
    
    @objc func tapCall(){
         callSelection?()
    }
    
    func handleSelection(){
        if isSelected{
            self.containerView.backgroundColor = Colors.accentColor()
            self.lblTitle.textColor = UIColor.white
            self.containerView.borderColor = UIColor.clear
        }
        else {
            self.containerView.backgroundColor = Colors.PlayerAttributeBoxColor()
            self.lblTitle.textColor = UIColor.black
            self.containerView.borderColor = Colors.PlayerCharacteristicCellBorderColor()
        }
    }

    func configureCell(item:[String:String]) {
        
        self.imageView.image = UIImage(named: item["image"]!)
        self.lblTitle.text = item["title"]
    }
    
}
