//
//  NestedTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!

    @IBOutlet weak var mediaImageView: UIImageView!

    func populateData(media: PlayerMedias?) -> Void {
        
        labelTitle.text = media?.title
        labelSubtitle.text = media?.subtitle
        mediaImageView.setImage(with: media?.preview, placeholder: nil)
        
        self.contentView.layoutIfNeeded()
    }
}
