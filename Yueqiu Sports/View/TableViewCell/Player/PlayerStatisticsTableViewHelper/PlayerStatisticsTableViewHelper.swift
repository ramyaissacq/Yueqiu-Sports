//
//  TeamPlayerTableViewHelper.swift
//  SportScore
//
//  Created by Abdullah on 18/01/2023.
//

import Foundation
import UIKit

class PlayerStatisticsTableViewHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var statistics : [Statistics]?
    var selectedIndex : Int = 0
    
    func updateWithItems(items : [Statistics]?) {
        
        self.statistics = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("section \(section+1) has \(statistics?[selectedIndex].statisticsData?.count ?? 0) rows")
        return section == 0 ? 1 : statistics?[selectedIndex].statisticsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamStandingsLeagueSelectionTableViewCell", for: indexPath) as! TeamStandingsLeagueSelectionTableViewCell
            
            let leagues = statistics?.compactMap({$0.league})
            
            cell.populateData(stats: leagues)
            cell.didSelectItemAtIndex = { [weak self] index in
                print("tapped index: \(index)")
                self?.selectedIndex = index
                cell.selectedIndex = index
                tableView.reloadSections([1], with: .fade)
            }
            cell.selectIndexAt(index: selectedIndex )
            cell.contentView.layoutIfNeeded()
            cell.layoutIfNeeded()
            return cell
            
        } else {
            
            let title = statistics?[selectedIndex].statisticsData?[indexPath.row].section ?? ""
            let rowData = statistics?[selectedIndex].statisticsData?[indexPath.row].data

            if title.lowercased() == "matches" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesTableViewCell", for: indexPath) as! MatchesTableViewCell
                cell.populateData(indicators: rowData)
                cell.contentView.layoutIfNeeded()
                cell.layoutIfNeeded()
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerAttributeTableViewCell", for: indexPath) as! PlayerAttributeTableViewCell
                cell.populateData(attributes: rowData, title: title, indexPath: indexPath)
                cell.contentView.layoutIfNeeded()
                cell.layoutIfNeeded()
                return cell
            }
        }
    }
    
    func reloadTable() {
        
        
    }
}
