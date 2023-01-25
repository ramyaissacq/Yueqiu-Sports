//
//  AboutPlayerTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class PlayerAttributeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundColour: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var nestedTableView: NestedUITableView!
    
    var indexPath: IndexPath?
    var activeTextField : UITextField?
    var attributes : [Rating]?
    
    func populateData(attributes:[Rating]?, title:String = "", indexPath: IndexPath) -> Void {
        self.attributes = attributes
        self.indexPath = indexPath
        self.labelTitle.text = title
                
        self.contentView.layoutIfNeeded()
        nestedTableView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib = UINib(nibName: "NestedTableViewCell", bundle: nil)
        nestedTableView.register(nib, forCellReuseIdentifier: "NestedTableViewCell")
        nestedTableView.delegate = self
        nestedTableView.dataSource = self
    }
}



extension PlayerAttributeTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attributes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NestedTableViewCell", for: indexPath) as! NestedTableViewCell
        cell.populateData(attribute: attributes?[indexPath.row])
        return cell
    }
}
