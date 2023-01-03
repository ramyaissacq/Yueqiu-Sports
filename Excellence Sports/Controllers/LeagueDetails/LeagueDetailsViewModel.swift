//
//  LeagueDetailsViewModel.swift
//  Excellence Sports
//
//  Created by Remya on 12/26/22.
//

import Foundation
import SwiftyJSON

protocol LeagueDetailsViewModelDelegate{
    func didFinishFetch()
    func didFinishPlayers()

}

class LeagueDetailsViewModel{
    var delegate:LeagueDetailsViewModelDelegate?
    var leaguDetails:LeagueResponse?
    var normalStandings:TeamStandingsResponse?
    var leaguStanding:LeagueStanding?
    var isNormalStanding = true
    var teamInfo = [TeamDetailsResponse]()
    var originalTeamInfo = [TeamDetailsResponse]()
    
    
    func getLeagueDetails(id:Int,subID:Int,grpID:Int){
      // Utility.showProgress()
        HomeAPI().getLeagueDetails(id: id, subID: subID, grpID: grpID) { json in
            let leagueJson = json?["leagueStanding"]
            self.analyseResponseJson(json: leagueJson, leagueID: id)
            self.leaguDetails = LeagueResponse(json!)
            self.collectPlayers()
            self.delegate?.didFinishFetch()
        } failed: { _ in
            
        }

    }
    
    func getTeamDetails(id:Int){
       
        HomeAPI().getTeamDetails(id: id) { response in
            if response != nil{
            self.originalTeamInfo.append(response!)
            }
            self.delegate?.didFinishPlayers()
            
        } failed: { _ in
            
        }

    }
    
    func analyseResponseJson(json:JSON?,leagueID:Int){
        if !(json?.arrayValue.first?["totalStandings"].isEmpty ?? true){
            normalStandings =  json?.arrayValue.map { TeamStandingsResponse($0) }.first
            isNormalStanding = true
            return
            
        }
        
        if json?.arrayValue.first?["list"].arrayValue.first?["subId"].intValue != 0{
            let subID = json?.arrayValue.first?["list"].arrayValue.first?["subId"].intValue ?? 0
            getLeagueDetails(id:leagueID,subID:subID,grpID:0)
            return
        }
        else{
            print("Empty json")
            leaguStanding = json?.arrayValue.map { LeagueStanding($0) }.first
            isNormalStanding = false
            
        }
    }
    
   
    
    func getPlayerFrom(obj:TeamDetailsResponse)->TeamPlayerData?{
        return obj.teamPlayerData?.sorted{(Int($0.value ?? "") ?? 0) > (Int($1.value ?? "") ?? 0)}.first
    }
    
    func collectPlayers(){
        if isNormalStanding{
            for m in normalStandings?.teamInfo ?? []{
                getTeamDetails(id: m.teamId ?? 0)
            }
        }
        else{
            for i in 0...(leaguStanding?.list?.first?.score?.first?.groupScore?.count ?? 0)-1{
                for j in 0...(leaguStanding?.list?.first?.score?.first?.groupScore?[i].scoreItems?.count ?? 0)-1{
                   
                    if let teamID = Int(leaguStanding?.list?.first?.score?.first?.groupScore?[i].scoreItems?[j].teamId ?? ""){
                       getTeamDetails(id: teamID)
                    }
                    
                }
                
            }
                    
                   
        }
        
    }
}
