//
//  HomeViewController.swift
//  CoolSports
//
//  Created by Remya on 12/15/22.
//

import UIKit
import ImageSlideshow

class HomeViewController:BaseViewController {

    @IBOutlet weak var fixedPlayer: UILabel!
    @IBOutlet weak var fixedSeeMorePlayer: UILabel!
    @IBOutlet weak var fixedSeeMore2: UILabel!
    @IBOutlet weak var fixedSeeMore: UILabel!
    @IBOutlet weak var fixedSeasons: UILabel!
    @IBOutlet weak var fixedLeagues: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewLeagues: UICollectionView!
    @IBOutlet weak var collectionViewSeasons: UICollectionView!
    @IBOutlet weak var imageSlideshow:ImageSlideshow!
    @IBOutlet weak var collectionViewPlyears: UICollectionView!
    
    var leagues:[FootballLeague]?
    
    let viewModel = HomeViewModel()
    let pageIndicator = UIPageControl()
    static var urlDetails:UrlDetails?
    static var popupFlag = 1
    static var timer = Timer()
    static var fromLanguage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.popupFlag = 1
        setupLeftView()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        HomeViewController.popupFlag = 0
    }
    
    
    @IBAction func actionSearch(_ sender: UIButton) {
        openLeagues()
    }
    
    
    func initialSettings(){
        fixedLeagues.text = "Leagues".localized
        fixedSeasons.text = "Seasons".localized
        fixedSeeMore2.text = "See More".localized
        fixedSeeMore.text = "See More".localized
        fixedSeeMorePlayer.text = "See More".localized
        fixedPlayer.text = "Players".localized
        
        FootballLeague.populateFootballLeagues()
        leagues = FootballLeague.leagues
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSlides), name: Notification.Name("RefreshSlideshow"), object: nil)
        collectionViewLeagues.registerCell(identifier: "LeagueCollectionViewCell")
        collectionViewSeasons.registerCell(identifier: "LeagueCollectionViewCell")
        collectionViewPlyears.registerCell(identifier: "PlayersCollectionViewCell")
        viewModel.delegate = self
        viewModel.getSeasons(page: 1)
        viewModel.getPlyearList(pageNumber: 1)
    }
    
    @objc func refreshSlides(){
        if HomeViewController.urlDetails?.mapping?.count ?? 0 > 0{
            setupSlideshow()
        }
       
    }
    
    
    @IBAction func actionMorePlayers(_ sender: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayersViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func actionSeeMoreLeagues(_ sender: Any) {
        openLeagues()
    }
    
    @IBAction func actionSeeMoreSeasons(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeasonsViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func openLeagues(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    func setupLeftView(){
      
        if AppPreferences.getMapObject() != nil{
           
            let btn = getButton(image: UIImage(named: "next"))
            //let gradient = btn.getGradientLayer(bounds: btn.bounds)
            btn.backgroundColor = Colors.accentColor()
            btn.cornerRadius = 4
            //btn.gradientColor(bounds: btn.bounds, gradientLayer: gradient)
            btn.addTarget(self, action: #selector(specialButtonAction), for: .touchUpInside)
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn)]
        }
        
       
    }
    
    @objc func specialButtonAction() {
        if AppPreferences.getMapObject()?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
            let urlString = AppPreferences.getMapObject()?.redirectUrl ?? ""
        gotoWebview(url: urlString)
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: AppPreferences.getMapObject()?.redirectUrl ?? "") else{return}
                    Utility.openUrl(url: url)
        }
        
    }
    
    func setupNavBar(){
        let img = UIImageView(image: UIImage(named: "topImage"))
        self.navigationItem.titleView = img
        let btn = getButton(image: UIImage(named: "menu"))
        btn.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    @objc func toSettings(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoWebview(url:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if url != ""{
            vc.urlString = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
       // clearSearch()
        
    }
    
    static func configureTimer(){
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
        let time:Double = Double(HomeViewController.urlDetails?.prompt?.repeat_time ?? 0)
       timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc static func timerAction(){
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
            HomeViewController.openPrompt()
        }
    }
   
   
    static func showPopup(){
        
        NotificationCenter.default.post(name: Notification.Name("RefreshSlideshow"), object: nil)
        let frequency = AppPreferences.getPopupFrequency()
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
         openPrompt()
        
        }
        else{
        let promptFrequency = HomeViewController.urlDetails?.prompt?.frequency ?? 0
        if frequency < promptFrequency{
            openPrompt()
            AppPreferences.setPopupFrequency(frequency: frequency+1)
        }
        }
    }
    
    static func openPrompt(){
        //
        if HomeViewController.fromLanguage{
            HomeViewController.fromLanguage = false
            //timer.invalidate()
            //configureTimer()
            return
        }
        if HomeViewController.popupFlag == 1{
            timer.invalidate()
        let title = HomeViewController.urlDetails?.prompt?.title ?? ""
        let message = HomeViewController.urlDetails?.prompt?.message ?? ""
            let btnText = HomeViewController.urlDetails?.prompt?.button ?? "OK".localized
        Dialog.openSpecialSuccessDialog(buttonLabel: btnText, title: title, msg: message, completed: {}, tapped: {
            configureTimer()
            if HomeViewController.urlDetails?.prompt?.redirect_url?.count ?? 0 > 0{
            var mapObj = Mapping()
            mapObj.openType = HomeViewController.urlDetails?.prompt?.open_type
            mapObj.redirectUrl = HomeViewController.urlDetails?.prompt?.redirect_url
            AppPreferences.setMapObject(obj: mapObj)
            }
            else{
                return
            }
            
            if HomeViewController.urlDetails?.prompt?.open_type == "0"{
                AppPreferences.setIsSearched(value: true)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
                
                    vc.urlString = HomeViewController.urlDetails?.prompt?.redirect_url ?? ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                if let nav = appDelegate?.window?.rootViewController as? UINavigationController{
                nav.pushViewController(vc, animated: true)
                }
            }
            else{
                AppPreferences.setIsSearched(value: false)
                guard let url = URL(string: HomeViewController.urlDetails?.prompt?.redirect_url ?? "") else{return}
                Utility.openUrl(url: url)
            }
            
        }, closed: {
            configureTimer()
        })
        }
    }
    
    
    func setupSlideshow(){
       
        pageIndicator.currentPageIndicatorTintColor =  Colors.accentColor()
        pageIndicator.pageIndicatorTintColor = UIColor.black
        pageIndicator.numberOfPages = HomeViewController.urlDetails?.banner?.count ?? 0
        imageSlideshow.pageIndicator = pageIndicator
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.slideshowInterval = 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        if HomeViewController.urlDetails?.banner?.count ?? 0 > 0{
            var images = [InputSource]()
            for m in HomeViewController.urlDetails?.banner ?? []{
                if let src = KingfisherSource(urlString: m.image ?? ""){
                    images.append(src)
                }
            }
            imageSlideshow.setImageInputs(images)
            imageSlideshow.isHidden = false
        }
        else{
            imageSlideshow.isHidden = true
        }
       
    }
    
    
    @objc func didTap(){
        let index = pageIndicator.currentPage
        let banner = HomeViewController.urlDetails?.banner?[index]
        var mapObj = Mapping()
        mapObj.openType = banner?.openType
        mapObj.redirectUrl = banner?.redirectUrl
        AppPreferences.setMapObject(obj: mapObj)
        if banner?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
        gotoWebview(url: banner?.redirectUrl ?? "")
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: banner?.redirectUrl ?? "") else{return}
            Utility.openUrl(url: url)
        }
        
    }
}

extension HomeViewController:HomeViewModelDelegate{
    func didFinishFetchPlyears() {
        collectionViewPlyears.reloadData()
    }
    
    func didFinishFetch() {
        collectionViewSeasons.reloadData()
    }
    
    
}



extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewLeagues{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionViewCell", for: indexPath) as! LeagueCollectionViewCell
            cell.configureCell(obj: leagues?[indexPath.row])
            return cell
        }
        else{
            if collectionView == collectionViewPlyears{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCollectionViewCell", for: indexPath) as! PlayersCollectionViewCell
                cell.configureCell(obj: viewModel.plyaerDetailsResponse?.data?[indexPath.row])
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionViewCell", for: indexPath) as! LeagueCollectionViewCell
                if indexPath.row < viewModel.seasons?.count ?? 0{
                    cell.configureCell(obj: viewModel.seasons?[indexPath.row])
                }
                return cell
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewLeagues{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
                    vc.leagueID = leagues?[indexPath.row].id
                    vc.leagueName = leagues?[indexPath.row].name
                    self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            if collectionView == collectionViewPlyears{
                    
                    let storyboard = UIStoryboard(name: "Player", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "PayerDetailsViewController") as! PayerDetailsViewController
                    viewController.currentPlayer = viewModel.plyaerDetailsResponse?.data?[indexPath.row]
                    self.navigationController?.pushViewController(viewController, animated: true)
                
                
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeasonDetailsViewController") as! SeasonDetailsViewController
                vc.leagueSlug = viewModel.seasons?[indexPath.row].leagueSlug
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.size.width - 56)/2
        return CGSize(width: w, height: 100)
    }
    
}




