//
//  LeaguesViewController.swift
//  Excellence Sports
//
//  Created by Remya on 1/13/23.
//

import UIKit

class LeaguesViewController: BaseViewController {

    @IBOutlet weak var fixedLeagues: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewLeagues: UICollectionView!
    
    var leagues:[FootballLeague]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
  
    func initialSettings(){
        leagues = FootballLeague.leagues
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.placeholder = "Search Here".localized
        setupNavBar()
        collectionViewLeagues.registerCell(identifier: "LeagueCollectionViewCell")
        fixedLeagues.text = "Leagues".localized
       
    }
    
    func setupNavBar(){
        let headerLbl = getHeaderLabel(title: "Leagues".localized)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: getBackButton()),UIBarButtonItem(customView: headerLbl)]
        
    }

}


extension LeaguesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagues?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionViewCell", for: indexPath) as! LeagueCollectionViewCell
            cell.configureCell(obj: leagues?[indexPath.row])
            return cell
   
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
                vc.leagueID = leagues?[indexPath.row].id
                vc.leagueName = leagues?[indexPath.row].name
                self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.size.width - 56)/2
        return CGSize(width: w, height: 100)
    }
    
}

extension LeaguesViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
////        searchBar.resignFirstResponder()
////        searchBar.endEditing(true)
//        return true
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
                doSearch(text: searchText)

            }

        }
        else{
            leagues = FootballLeague.leagues
            collectionViewLeagues.reloadData()
            //self.view.endEditing(true)
        }
    }

    func doSearch(text:String){
        leagues = FootballLeague.leagues?.filter{$0.name?.contains(text) ?? false}
        collectionViewLeagues.reloadData()
    }

    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        leagues = FootballLeague.leagues
        collectionViewLeagues.reloadData()
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
