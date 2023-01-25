//
//  NestedTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTotalGamesPlayed: UILabel!
    @IBOutlet weak var labelGamesStarted: UILabel!
    @IBOutlet weak var labelMinutesPerGame: UILabel!


    func populateData(indicators: [Rating]?) -> Void {
        
        let totalGamesPlayed = indicators?.filter {$0.key == "Total played"}.first?.value ?? ""
        let gamesStarted = indicators?.filter {$0.key == "Started"}.first?.value ?? ""
        let minutesPerGame = indicators?.filter {$0.key == "Minutes per game"}.first?.value ?? ""

        labelTotalGamesPlayed.text = totalGamesPlayed
        labelGamesStarted.text = gamesStarted
        labelMinutesPerGame.text = minutesPerGame

    }
}
