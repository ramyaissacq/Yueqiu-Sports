//
//  SelectionCollectionViewCell.swift
//  Excellence Sports
//
//  Created by Remya on 1/16/23.
//

import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var underLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            handleSelecetion()
            
        }
    }
    
    func handleSelecetion(){
        if isSelected{
            lblTitle.textColor = Colors.accentColor()
            underLineView.isHidden = false
        }
        else{
            lblTitle.textColor = .black
            underLineView.isHidden = true
            
        }
    }

}
