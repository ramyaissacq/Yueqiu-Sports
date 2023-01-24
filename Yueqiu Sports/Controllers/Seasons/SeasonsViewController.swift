//
//  SeasonsViewController.swift
//  Excellence Sports
//
//  Created by Remya on 1/14/23.
//

import UIKit

class SeasonsViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewSeasons: UICollectionView!
    
    @IBOutlet weak var fixedSeasons: UILabel!
    
    let viewModel = HomeViewModel()
    var page = 1
    var currentSeasons:[SeasonData]?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettings()
    }
    

    func initialSettings(){
       
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.placeholder = "Search Here".localized
        fixedSeasons.text = "Seasons".localized
        setupNavBar()
        collectionViewSeasons.registerCell(identifier: "LeagueCollectionViewCell")
        viewModel.delegate = self
        viewModel.getSeasons(page: page)
    }
    
    func setupNavBar(){
        let headerLbl = getHeaderLabel(title: "Seasons".localized)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: getBackButton()),UIBarButtonItem(customView: headerLbl)]
        
    }


}

extension SeasonsViewController:HomeViewModelDelegate{
    func didFinishFetchPlyears() {
        
    }
    
    func didFinishFetch() {
        currentSeasons = viewModel.seasons
        collectionViewSeasons.reloadData()
        page += 1
    }
    
    
}



extension SeasonsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSeasons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchBar.text == ""{
        if indexPath.row == ((viewModel.seasons?.count ?? 0) - 1){
            if (viewModel.total ?? 0) > (viewModel.seasons?.count ?? 0 ){
                viewModel.getSeasons(page: page)
            }
            
        }
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionViewCell", for: indexPath) as! LeagueCollectionViewCell
        cell.configureCell(obj: currentSeasons?[indexPath.row])
            return cell
   
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeasonDetailsViewController") as! SeasonDetailsViewController
        vc.leagueSlug = currentSeasons?[indexPath.row].leagueSlug
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.size.width - 56)/2
        return CGSize(width: w, height: 100)
    }
    
}


extension SeasonsViewController:UISearchBarDelegate{
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
            currentSeasons = viewModel.seasons
            collectionViewSeasons.reloadData()
        }
    }

    func doSearch(text:String){
        currentSeasons = viewModel.seasons?.filter{$0.name?.contains(text) ?? false}
        collectionViewSeasons.reloadData()
    }

    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        currentSeasons = viewModel.seasons
        collectionViewSeasons.reloadData()
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
