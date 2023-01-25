//
//  NestedTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class EventMatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelMatchDate: UILabel!
    @IBOutlet weak var labelHomeTeamName: UILabel!
    @IBOutlet weak var labelAwayTeamName: UILabel!
    
    @IBOutlet weak var labelHomeTeamScore: UILabel!
    @IBOutlet weak var labelAwayTeamScore: UILabel!
    
    @IBOutlet weak var labelRoundName: UILabel!


    func populateData(match: PlayerMatches?) -> Void {
        
        labelHomeTeamName.text = match?.homeName
        labelAwayTeamName.text = match?.awayName
        
        labelHomeTeamScore.text = match?.homeScore
        labelAwayTeamScore.text = match?.awayScore
        
        labelRoundName.text = match?.round?.replacingOccurrences(of: "Round ", with: "")        
    }
}
