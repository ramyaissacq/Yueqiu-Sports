//
//  ProfileViewController.swift
//  CoolSports
//
//  Created by Remya on 12/19/22.
//

import UIKit
import Lottie

class ProfileViewController: BaseViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    
    var playerID:Int?
    var leagueName:String?
    var player:TeamPlayerData?
    var team:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    func initialSettings(){
        setBackButton()
        self.navigationItem.titleView = getHeaderLabel(title: "Player Info".localized)
        tableView.register(UINib(nibName: "LeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueDetailsTableViewCell")
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        imgProfile.setImage(with: player?.photo, placeholder: Utility.getPlaceHolder())
        if Utility.getCurrentLang() == "cn"{
            lblPlayer.text = player?.nameChs
        }
        else{
        lblPlayer.text = player?.nameEn
        }
        lblTeam.text = team
        tableView.reloadData()
       
    }
    
    func getDataAt(index:Int) -> League?{
        
        var league:League?
        switch index{
        case 0:
            var value = player?.nameEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.nameChs
            }
            league = League(key: "Full Name".localized.localized, value: value ?? "")
        case 1:
            var value = player?.countryEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.countryCn
            }
            league = League(key: "Country".localized.localized, value: value ?? "")
        case 2:
            let value = player?.birthday
            
            league = League(key: "Birthday".localized.localized, value: value ?? "")
        case 3:
            let value = player?.height
            
            league = League(key: "Height".localized.localized, value: value ?? "")
        case 4:
            let value = player?.weight
            
            league = League(key: "Weight".localized.localized, value: value ?? "")
        case 5:
            var value = player?.positionEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.positionCn
            }
            league = League(key: "Position".localized.localized, value: value ?? "")
        case 6:
            let value = player?.number
            
            league = League(key: "Number".localized.localized, value: value ?? "")
        case 7:
            let value = player?.endDateContract
            
            league = League(key: "Contract Ending".localized.localized, value: value ?? "")
            
        default:
            break
        }
        return league
    }
    
    
    
}




extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
            return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return 8
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
        cell.configureCell(obj: getDataAt(index: indexPath.row))
        cell.keyColor = Colors.gray2Color()
        cell.valueColor = .black
            return cell

        
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
  
}
