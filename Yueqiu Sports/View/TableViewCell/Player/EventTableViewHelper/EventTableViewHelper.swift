//
//  EventTableViewHelper.swift
//  SportScore
//
//  Created by Abdullah on 18/01/2023.
//

import Foundation
import UIKit

class EventTableViewHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var eventItems : [PlayerDetailsEvents]?
    
    func updateWithItems(items : [PlayerDetailsEvents]?) {
        
        self.eventItems = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        cell.populateData(matches: eventItems?[indexPath.row].matches, title: eventItems?[indexPath.row].leagueName ?? "", imageUrl: eventItems?[indexPath.row].leagueLogo ?? "")
        cell.contentView.layoutIfNeeded()
        cell.layoutIfNeeded()
        return cell
        
    }
}
