//
//  MediaTableViewHelper.swift
//  SportScore
//
//  Created by Abdullah on 18/01/2023.
//

import Foundation
import UIKit

class MediaTableViewHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var mediaItems : [PlayerMedias]?
    
    func updateWithItems(items : [PlayerMedias]?) {
        
        self.mediaItems = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mediaItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        cell.populateData(media: mediaItems?[indexPath.row])
        cell.contentView.layoutIfNeeded()
        return cell
        
    }
}
