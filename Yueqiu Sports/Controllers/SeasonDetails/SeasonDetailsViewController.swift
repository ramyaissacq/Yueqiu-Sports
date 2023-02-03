//
//  SeasonDetailsViewController.swift
//  Excellence Sports
//
//  Created by Remya on 1/14/23.
//

import UIKit
import Lottie

class SeasonDetailsViewController: BaseViewController {

    @IBOutlet weak var btnInfo: UIButton!
    
    @IBOutlet weak var btnPerformance: UIButton!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblLeague: UILabel!
    
    @IBOutlet weak var lblSeason: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    var selectionIndex = 0
    var viewModel = SeasonDetailsViewModel()
    var leagueSlug:String?
    var selectedSeasonIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    
    
    @IBAction func actionInfo(_ sender: Any) {
        btnInfo.backgroundColor = Colors.accentColor()
        btnInfo.setTitleColor(.white, for: .normal)
        btnPerformance.backgroundColor = .white
        btnPerformance.titleLabel?.textColor = Colors.accentColor()
        selectionIndex = 0
        collectionView.isHidden = true
        tableView.reloadData()
    }
    

    @IBAction func actionPerformance(_ sender: Any) {
        btnPerformance.backgroundColor = Colors.accentColor()
        btnPerformance.setTitleColor(.white, for: .normal)
        btnInfo.backgroundColor = .white
        btnInfo.titleLabel?.textColor = Colors.accentColor()
        selectionIndex = 1
        collectionView.isHidden = false
        tableView.reloadData()
    }
    
    func initialSettings(){
        
        let btn = getBackButton()
        let header = getHeaderLabel(title: "Season Info".localized,color: Colors.gray1Color())
       self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn),UIBarButtonItem(customView: header)]
        btnInfo.setTitle("Info".localized, for: .normal)
        btnPerformance.setTitle("Performance".localized, for: .normal)
        tableView.register(UINib(nibName: "LeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueDetailsTableViewCell")
        tableView.register(UINib(nibName: "SeasonHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "seasonHeaderTableViewCell")
        tableView.register(UINib(nibName: "PieTableViewCell", bundle: nil), forCellReuseIdentifier: "pieTableViewCell")
        collectionView.registerCell(identifier: "SelectionCollectionViewCell")
        tableView.register(UINib(nibName: "TeamRowTableViewCell", bundle: nil), forCellReuseIdentifier: "teamRowTableViewCell")
        tableView.register(UINib(nibName: "TeamHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "teamHeaderTableViewCell")
        configureLottieAnimation()
        viewModel.delegate = self
        viewModel.getSeasonDetails(slug: leagueSlug!)
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    

}

extension SeasonDetailsViewController:SeasonDetailsProtocol{
    
    func didFinishFetch() {
        lblLeague.text = viewModel.seasonDetails?.name
        lblSeason.text = viewModel.seasonDetails?.season
        imgLogo.setImage(with: viewModel.seasonDetails?.photo, placeholder: Utility.getPlaceHolder())
        tableView.reloadData()
        collectionView.reloadData()
        if viewModel.seasonDetails?.seasonPerformance?.count ?? 0 > 0{
            self.emptyView.isHidden = true
            animationView.stop()
            collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
        else{
            self.emptyView.isHidden = false
            animationView.play()
        }
        
    }
    
    
}


extension SeasonDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectionIndex == 0{
        return 3
        }
        else{
            return viewModel.seasonDetails?.seasonPerformance?[selectedSeasonIndex].data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectionIndex == 0{
        if section == 0{
            return 4
        }
        
        else if section == 1{
            return viewModel.seasonDetails?.tournamentPerformance?.count ?? 0
        }
        else{
            return 1
        }
        }
        else{
            return (viewModel.getSubRowCount(section: selectedSeasonIndex, row: section) + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectionIndex == 0{
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
            cell.configureCell(obj: viewModel.getProfileRowAt(index: indexPath.row))
        cell.keyColor = Colors.gray1Color()
        cell.valueColor = .black
        return cell
            
        }
        
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
            let league = League(key: viewModel.seasonDetails?.tournamentPerformance?[indexPath.row].key ?? "", value: viewModel.seasonDetails?.tournamentPerformance?[indexPath.row].value ?? "")
            cell.configureCell(obj: league)
            cell.keyColor = Colors.gray1Color()
            cell.valueColor = .black
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "pieTableViewCell", for: indexPath) as! PieTableViewCell
            cell.updateChartData(values: viewModel.getTournamentPieChartValues())
            return cell
        }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamRowTableViewCell", for: indexPath) as! TeamRowTableViewCell
            if indexPath.row == 0{
                cell.isTitleRow = true
                cell.row = viewModel.getHeaderRow(index: selectedSeasonIndex)
            }
            else{
                cell.isTitleRow = false
                cell.row = viewModel.getSubrow(section: selectedSeasonIndex, row: indexPath.section, subRow: indexPath.row-1)
            }
            cell.collectionViewTeam.reloadData()
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if selectionIndex == 0{
        if section == 1{
            return 40
        }
        else{
            return CGFloat.leastNormalMagnitude
        }
        }
        else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if selectionIndex == 0{
        if section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "seasonHeaderTableViewCell") as! SeasonHeaderTableViewCell
            cell.lblHeader.text = "Facts".localized
            return cell
        }
        else{
            return nil
        }
        }
        else{ // Performance
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamHeaderTableViewCell") as! TeamHeaderTableViewCell
            cell.lblTitle.text = viewModel.seasonDetails?.seasonPerformance?[selectedSeasonIndex].data?[section][2]
            cell.imgTeamLogo.setImage(with: viewModel.seasonDetails?.seasonPerformance?[selectedSeasonIndex].data?[section].first, placeholder: Utility.getPlaceHolder())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
}

extension SeasonDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.seasonDetails?.seasonPerformance?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCollectionViewCell", for: indexPath) as! SelectionCollectionViewCell
        cell.lblTitle.text = viewModel.seasonDetails?.seasonPerformance?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSeasonIndex = indexPath.row
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing:CGFloat = 40
        let w = (UIScreen.main.bounds.width - spacing)/2
        return CGSize(width: w, height: 35)
    }
}
