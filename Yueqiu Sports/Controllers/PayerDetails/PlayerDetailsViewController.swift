//
//  ViewController.swift
//  SportScore
//
//  Created by Abdullah on 14/01/2023.
//

import UIKit
import Lottie

class PayerDetailsViewController: BaseViewController {
    
    @IBOutlet weak var fixedRating: UILabel!
    @IBOutlet weak var fixedNumber: UILabel!
    @IBOutlet weak var fixedMarketPrice: UILabel!
    @IBOutlet weak var fixedAge: UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var playerCharacteristicsCollectionView : UICollectionView!
    @IBOutlet weak var playerNameLabel : UILabel!
    @IBOutlet weak var playerPlayingPositionLabel : UILabel!
    @IBOutlet weak var playerTeamNameLabel : UILabel!
    @IBOutlet weak var playerCountryNameLabel : UILabel!
    @IBOutlet weak var playerAgeLabel : UILabel!
    @IBOutlet weak var playerMarketPriceLabel : UILabel!
    @IBOutlet weak var playerJerseyNumberLabel : UILabel!
    @IBOutlet weak var playerRatingLabel : UILabel!
    @IBOutlet weak var playerImageView : UIImageView!
    @IBOutlet weak var playerClubImageView : UIImageView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    let viewModel = PayerDetailsViewModel()
    var currentPlayer : PlayerDetailsData?
    
    let mediaTableViewHelper = MediaTableViewHelper()
    let eventTableViewHelper = EventTableViewHelper()
    let statsTableViewHelper = PlayerStatisticsTableViewHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBarColor(color: Colors.accentColor())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavBarColor()
    }

    func setupUI() {
        configureLottieAnimation()
        let btn = getBackButton(image: UIImage(named: "WhiteBack"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        tableView.register(UINib(nibName: "AboutPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutPlayerTableViewCell")
        tableView.register(UINib(nibName: "PlayerAttributeTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerAttributeTableViewCell")
        tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        tableView.register(UINib(nibName: "TeamStandingsLeagueSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamStandingsLeagueSelectionTableViewCell")
        //MatchesTableViewCell
        tableView.register(UINib(nibName: "MatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchesTableViewCell")

        playerCharacteristicsCollectionView.registerCell(identifier: "PlayerCharacteristicsCollectionViewCell")
        playerCharacteristicsCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        
        let tableBackgroundView = TableBackgroundView.init(frame: CGRectMake(0, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height * 0.4))
        tableView.backgroundView = tableBackgroundView
        fixedRating.text = "Rating".localized
        fixedNumber.text = "Number".localized
        fixedMarketPrice.text = "Market Price".localized
        fixedAge.text = "Age".localized
        
      
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
    func configureViewModel() {
        
        tableView.isHidden = true
      
        viewModel.didFetchedPlayerDetails = { [weak self] boolean in
            
            DispatchQueue.main.async {
                
                self?.tableView.fadeIn(0.4)
                self?.setupPlayerUI()
                self?.tableView.reloadData()
                if self?.viewModel.playerData != nil{
                    self?.emptyView.isHidden = true
                    self?.animationView.stop()
                }
                else{
                    self?.emptyView.isHidden = false
                    self?.animationView.play()
                }
            }
            
        }
        viewModel.fetchPlayterDetails(player: currentPlayer)
    }
    
    func setupPlayerUI() {
        
        self.playerNameLabel.text = viewModel.playerData?.playerName
        self.playerPlayingPositionLabel.text = viewModel.playingPosition()

        self.playerAgeLabel.text = viewModel.playerAge()
        self.playerMarketPriceLabel.text = viewModel.playerMarketPrice()
        self.playerJerseyNumberLabel.text = viewModel.playerNumber()
        self.playerRatingLabel.text = viewModel.playerRating()

        self.playerTeamNameLabel.text = viewModel.playerData?.teamName
        self.playerCountryNameLabel.text = viewModel.playerData?.playerCountry?.capitalized

        self.playerImageView.setImage(with: viewModel.playerData?.playerPhoto, placeholder: nil)
        self.playerClubImageView.setImage(with: viewModel.playerData?.teamPhoto, placeholder: nil)
        
        mediaTableViewHelper.updateWithItems(items: viewModel.playerData?.medias)
        eventTableViewHelper.updateWithItems(items: viewModel.playerData?.events)
        statsTableViewHelper.updateWithItems(items: viewModel.playerData?.statistics)
    }
}

extension PayerDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutPlayerTableViewCell", for: indexPath) as! AboutPlayerTableViewCell
            cell.populateData(aboutUs: aboutPlayerArray(), aboutText: viewModel.playerData?.about ?? "")
            cell.layoutIfNeeded()
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerAttributeTableViewCell", for: indexPath) as! PlayerAttributeTableViewCell
            cell.populateData(attributes: viewModel.playerData?.rating, title: "Rating".localized, indexPath: indexPath)
            cell.contentView.layoutIfNeeded()
            return cell
        }
    }
    
    func aboutPlayerArray() -> [Rating] {
        
        return viewModel.playerData?.indicators?.filter {$0.key != "Age" && $0.key != "Market price" && $0.key != "Player number"  && $0.key != "Rating"} ?? [Rating]()
    }
}


extension PayerDetailsViewController:  UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characteristics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCharacteristicsCollectionViewCell", for: indexPath) as! PlayerCharacteristicsCollectionViewCell
        let item = viewModel.characteristics[indexPath.item] as [String:String]
        cell.configureCell(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: viewModel.characteristicsCellWidth[indexPath.item], height: 59)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = viewModel.characteristics[indexPath.item] as [String:String]
        if item["title"] == "Info".localized {
            
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
        } else if item["title"] == "Events".localized {
            
            self.tableView.dataSource = eventTableViewHelper
            self.tableView.delegate = eventTableViewHelper
            
        } else if item["title"] == "Media".localized {
            
            self.tableView.dataSource = mediaTableViewHelper
            self.tableView.delegate = mediaTableViewHelper
            
        } else if item["title"] == "Statistics".localized {
            
            self.tableView.dataSource = statsTableViewHelper
            self.tableView.delegate = statsTableViewHelper
        }
        
        self.reloadTable()
        self.perform(#selector(reloadTable), with: nil, afterDelay: 0.4)
    }
    
    @objc func reloadTable() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.reloadData()
        }
    }
}

