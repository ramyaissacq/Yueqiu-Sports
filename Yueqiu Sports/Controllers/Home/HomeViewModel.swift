//
//  HomeViewModel.swift
//  Excellence Sports
//
//  Created by Remya on 1/14/23.
//

import Foundation
protocol HomeViewModelDelegate{
    func didFinishFetch()
    func didFinishFetchPlyears()
}

class HomeViewModel{
    var seasons: [SeasonData]?
    var total:Int?
    var delegate:HomeViewModelDelegate?
    var plyaerDetailsResponse:PlayerDetailsResponse?

    func getPlyearList(pageNumber:Int){
        HomeAPI().getPlyearsList(pageNumber: pageNumber) { response in
            if self.plyaerDetailsResponse == nil{
            self.plyaerDetailsResponse = response
            }
            else{
                self.plyaerDetailsResponse?.data?.append(contentsOf: response?.data ?? [])
            }
            self.delegate?.didFinishFetchPlyears()
        } failed: { _ in
            
        }

    }
    
    func getSeasons(page:Int){
        HomeAPI().getseasons(page: page) { response in
            self.total = response?.total
            if self.seasons == nil{
                self.seasons = response?.data
            }
            else{
                self.seasons?.append(contentsOf: response?.data ?? [])
            }
            
            self.delegate?.didFinishFetch()
        } failed: { msg in
            Utility.showErrorSnackView(message: msg)
        }

    }
    
}
