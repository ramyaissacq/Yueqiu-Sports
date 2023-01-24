//
//  SeasonDetailsViewModel.swift
//  Excellence Sports
//
//  Created by Remya on 1/14/23.
//

import Foundation

protocol SeasonDetailsProtocol{
    func didFinishFetch()
}


class SeasonDetailsViewModel{
    var seasonDetails:SesonDetailsData?
    var delegate:SeasonDetailsProtocol?
    
    func getSeasonDetails(slug:String){
        HomeAPI().getseasonDetails(slug: slug) { response in
            self.seasonDetails = response?.data
            self.delegate?.didFinishFetch()
            
        } failed: { _ in
            
        }

    }
    
    
    
    func getProfileRowAt(index:Int) -> League?{
        switch index{
        case 0:
            let league = League(key: "Season Name:".localized, value: seasonDetails?.name ?? "")
            return league
        case 1:
            let league = League(key: "Host Country:".localized, value: seasonDetails?.hostCountry ?? "")
            return league
        case 2:
            let league = League(key: "Start Date:".localized, value: seasonDetails?.seasonStartDate ?? "")
            return league
        case 3:
            let league = League(key: "End Date:".localized, value: seasonDetails?.seasonEndDate ?? "")
            return league
            
        default:
            return nil
        }
       
    }
    
    
    func getTournamentPieChartValues() ->[Double]{
        var values = [Double]()
        for m in seasonDetails?.tournamentPerformance ?? []{
            if m.key == "Home team wins".localized{
                let homeValue = m.value?.components(separatedBy: "%").first ?? ""
                values.append(Double(homeValue) ?? 0)
            }
            
            if m.key == "Away team wins".localized{
                let awayValue = m.value?.components(separatedBy: "%").first ?? ""
                values.append(Double(awayValue) ?? 0)
            }
            
            if m.key == "Draws".localized{
                let drawsValue = m.value?.components(separatedBy: "%").first ?? ""
                values.append(Double(drawsValue) ?? 0)
            }
        }
        return values
      
    }
    
    func getSubRowCount(section:Int,row:Int) -> Int{
        let arrayCount = seasonDetails?.seasonPerformance?[section].data?[row].count ?? 0
        return (arrayCount - 3)/3
        
    }
    
    func getSubrow(section:Int,row:Int,subRow:Int) ->[String]{
        let rowArray = seasonDetails?.seasonPerformance?[section].data?[row]
        let distance = getSubRowCount(section: section, row: row)
        var resultArray = [String]()
       let hdr = seasonDetails?.seasonPerformance?[section].subheader?[3+subRow] ?? ""
        resultArray.append(hdr)
        resultArray.append(rowArray?[3+subRow] ?? "")
        resultArray.append(rowArray?[3+subRow+distance] ?? "")
        resultArray.append(rowArray?[3+subRow+(2*distance)] ?? "")
        return resultArray
    }
    
    func getHeaderRow(index:Int) -> [String]{
        var rowArray = ["","Overall/Avg".localized,"Home".localized,"Away".localized]
        let first = seasonDetails?.seasonPerformance?[index].name ?? ""
        rowArray[0] = first
        return rowArray
    }
    
    
}
