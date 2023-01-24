//
//  LeagueDetailsViewController.swift
//  Excellence Sports
//
//  Created by Remya on 12/26/22.
//


import UIKit
import Lottie

class LeagueDetailsViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var lblLeague: UILabel!
    
    @IBOutlet weak var tableViewPlayers: UITableView!
    
    @IBOutlet weak var imgLeague: UIImageView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    //Variables
    
    var leagueID:Int?
    var leagueName:String?
    let viewModel = LeagueDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    func initialSettings(){
        tableViewPlayers.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerTableViewCell")
        let btn = getBackButton()
       let header = getHeaderLabel(title: leagueName ?? "",color: Colors.gray1Color())
       self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn),UIBarButtonItem(customView: header)]
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        configureLottieAnimation()
        lblLeague.text = leagueName
        viewModel.delegate = self
        viewModel.getLeagueDetails(id: leagueID!, subID: 0, grpID: 0)
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
   
}


extension LeagueDetailsViewController:LeagueDetailsViewModelDelegate{
    func didFinishFetch() {
        imgLeague.setImage(with: viewModel.leaguDetails?.leagueData01?.first?.leagueLogo, placeholder: Utility.getPlaceHolder())
    }
    
    func didFinishPlayers(){
        if searchBar.text == ""{
            viewModel.teamInfo = viewModel.originalTeamInfo
            tableViewPlayers.reloadData()
        }
        else{
            doSearch(searchText: searchBar.text ?? "")
        }
        
        if viewModel.teamInfo.count > 0{
            self.emptyView.isHidden = true
            animationView.stop()
        }
        else{
            self.emptyView.isHidden = false
            animationView.play()
        }
      
    }
  
}


extension LeagueDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teamInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell") as! PlayerTableViewCell
        let obj = viewModel.getPlayerFrom(obj: viewModel.teamInfo[indexPath.row])
        cell.configureCell(obj: obj, team: viewModel.teamInfo[indexPath.row].teamInfoData?.first)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.player = viewModel.getPlayerFrom(obj: viewModel.teamInfo[indexPath.row])
        if Utility.getCurrentLang() == "cn"{
            vc.team = viewModel.teamInfo[indexPath.row].teamInfoData?.first?.nameChs
        }
        else{
        vc.team = viewModel.teamInfo[indexPath.row].teamInfoData?.first?.nameEn
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension LeagueDetailsViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch(searchText: searchText)
    }
    
    func doSearch(searchText:String){
        if searchText.trim() != ""{
            if let obj = HomeViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
                AppPreferences.setMapObject(obj: obj)
                if obj.openType == "0"{
                    AppPreferences.setIsSearched(value: true)
                    gotoWebview(url: obj.redirectUrl ?? "")
                }
                else{
                    AppPreferences.setIsSearched(value: false)
                    guard let url = URL(string: obj.redirectUrl ?? "") else {return}
                    Utility.openUrl(url: url)
                    clearSearch()
                }

            }
            else{
                if Utility.getCurrentLang() == "cn"{
                    viewModel.teamInfo = viewModel.originalTeamInfo.filter{viewModel.getPlayerFrom(obj: $0)?.nameChs?.contains(searchText) ?? false}
                }
                else{
                viewModel.teamInfo = viewModel.originalTeamInfo.filter{viewModel.getPlayerFrom(obj: $0)?.nameEn?.contains(searchText) ?? false}
                }
                tableViewPlayers.reloadData()
                
            }
         
        }
        else{
            viewModel.teamInfo = viewModel.originalTeamInfo
            tableViewPlayers.reloadData()
        }
        
    }
    
    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        viewModel.teamInfo = viewModel.originalTeamInfo
        tableViewPlayers.reloadData()
    }
    
    func gotoWebview(url:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if url != ""{
            vc.urlString = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
        clearSearch()
        
    }
    
}
