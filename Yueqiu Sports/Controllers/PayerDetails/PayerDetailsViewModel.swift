//
//  PayerDetailsViewModel.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import Foundation

class PayerDetailsViewModel {
    
    var didFetchedPlayerDetails : ((Bool) -> Void)?
    
    var playerData : PlayerData?
    
    var characteristics = [["image":"info", "title":"Info".localized],
                           ["image":"stats", "title":"Statistics".localized],
                           ["image":"events", "title":"Events".localized],
                           ["image":"media", "title":"Media".localized],
    ]
    
    var characteristicsCellWidth = [100.0, 140.0, 122.0, 118.0]
    
    
    func fetchPlayterDetails(player:PlayerDetailsData?) {
        
        HomeAPI().getPlayerDetails(slug: player?.slug ?? "") { [weak self] response in
            
            self?.playerData = response.playerData
            self?.didFetchedPlayerDetails?(true)
            
        } failed: { error in
            print("error is \(error)")
        }
    }
    
    func playerAge() -> String {
        return self.playerData?.indicators?.filter {$0.key == "Age"}.first?.value ?? ""
    }
    
    func playerMarketPrice() -> String {
        return self.playerData?.indicators?.filter {$0.key == "Market price"}.first?.value ?? ""
    }
    
    func playerNumber() -> String {
        return self.playerData?.indicators?.filter {$0.key == "Player number"}.first?.value ?? ""
    }
    
    func playerRating() -> String {
        return self.playerData?.indicators?.filter {$0.key == "Rating"}.first?.value ?? ""
    }
    
    func playingPosition() -> String {
        return self.playerData?.indicators?.filter {$0.key == "Main position"}.first?.value ?? ""
    }
}
