//
//  PlayersViewController.swift
//  Yueqiu Sports
//
//  Created by Remya on 1/24/23.
//

import UIKit

class PlayersViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewPlayers: UICollectionView!
    
    @IBOutlet weak var fixedPlayers: UILabel!
    
    let viewModel = HomeViewModel()
    var page = 1
    var currentPlayers:[PlayerDetailsData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    

    func initialSettings(){
       
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.placeholder = "Search Here".localized
        fixedPlayers.text = "Players".localized
        setupNavBar()
        collectionViewPlayers.registerCell(identifier: "PlayersCollectionViewCell")
        viewModel.delegate = self
        viewModel.getPlyearList(pageNumber: page)
    }
    
    func setupNavBar(){
        let headerLbl = getHeaderLabel(title: "Players".localized)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: getBackButton()),UIBarButtonItem(customView: headerLbl)]
    }

}


extension PlayersViewController:HomeViewModelDelegate{
    func didFinishFetchPlyears() {
        currentPlayers = viewModel.plyaerDetailsResponse?.data
        collectionViewPlayers.reloadData()
        page += 1
        
    }
    
    func didFinishFetch() {
        
    }
    
    
}


extension PlayersViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPlayers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchBar.text == ""{
            if indexPath.row == ((viewModel.plyaerDetailsResponse?.data?.count ?? 0) - 1){
                if (viewModel.plyaerDetailsResponse?.total ?? 0) > (viewModel.plyaerDetailsResponse?.data?.count ?? 0 ){
                viewModel.getPlyearList(pageNumber: page)
            }
            
        }
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCollectionViewCell", for: indexPath) as! PlayersCollectionViewCell
        cell.configureCell(obj: currentPlayers?[indexPath.row])
            return cell
   
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Player", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PayerDetailsViewController") as! PayerDetailsViewController
        viewController.currentPlayer = currentPlayers?[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.size.width - 56)/2
        return CGSize(width: w, height: 100)
    }
    
}


extension PlayersViewController:UISearchBarDelegate{
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
            currentPlayers = viewModel.plyaerDetailsResponse?.data
            collectionViewPlayers.reloadData()
        }
    }

    func doSearch(text:String){
        currentPlayers = viewModel.plyaerDetailsResponse?.data?.filter{$0.name?.contains(text) ?? false}
        collectionViewPlayers.reloadData()
    }

    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        currentPlayers = viewModel.plyaerDetailsResponse?.data
        collectionViewPlayers.reloadData()
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
