//
//  TeamRowTableViewCell.swift
//  Excellence Sports
//
//  Created by Remya on 1/16/23.
//

import UIKit

class TeamRowTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewTeam: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var row = [String]()
    var height:CGFloat = 35
    var isTitleRow = false{
        didSet{
            if isTitleRow{
                collectionViewHeight.constant = 50
                height = 50
            }
            else{
                collectionViewHeight.constant = 35
                height = 35
            }
        }
    }
    var sizeArray = [CGFloat]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        formSizes()
        collectionViewTeam.delegate = self
        collectionViewTeam.dataSource = self
        collectionViewTeam.registerCell(identifier: "TeamRowCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formSizes(){
        let spacing:CGFloat = 60
        let width = UIScreen.main.bounds.width - spacing
        sizeArray = [80,80,50,50]
        let extra = (width - (sizeArray.reduce(0,+)))/4
        sizeArray = sizeArray.map{$0+extra}
    }
    
}

extension TeamRowTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return row.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamRowCollectionViewCell", for: indexPath) as! TeamRowCollectionViewCell
        if isTitleRow{
            cell.lblTitle.font = UIFont(name: "NotoSans-Medium", size: 16)
            if indexPath.row == 0{
                cell.lblTitle.textColor = Colors.pieAwayColor()
            }
            else{
                cell.lblTitle.textColor = Colors.gray1Color()
            }
            cell.backView.backgroundColor = Colors.yellow2Color()
        }
        else{
            if indexPath.row == 0{
                cell.lblTitle.font = UIFont(name: "NotoSans-Medium", size: 16)
            }
            else{
                cell.lblTitle.font = UIFont(name: "NotoSans-Regular", size: 16)
            }
            cell.lblTitle.textColor = Colors.gray1Color()
            cell.backView.backgroundColor = .white
        }
        cell.lblTitle.text = row[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sizeArray[indexPath.row], height: height)
    }
    
    
}
