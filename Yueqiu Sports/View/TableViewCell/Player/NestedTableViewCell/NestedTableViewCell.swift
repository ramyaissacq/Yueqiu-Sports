//
//  NestedTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class NestedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attributeNameLabel: UILabel!
    @IBOutlet weak var attributeValueLabel: UILabel!

    func populateData(attribute: Rating?) -> Void {
        
        attributeNameLabel.text = attribute?.key
        attributeValueLabel.text = attribute?.value
        self.contentView.layoutIfNeeded()
    }
    
    func populateData(attribute: [String : String]?) -> Void {
        
        attributeNameLabel.text = attribute?["key"]
        attributeValueLabel.text = attribute?["value"]
        self.contentView.layoutIfNeeded()
    }
}
