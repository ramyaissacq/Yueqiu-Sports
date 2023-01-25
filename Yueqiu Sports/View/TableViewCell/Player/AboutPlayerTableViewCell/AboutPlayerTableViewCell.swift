//
//  AboutPlayerTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class AboutPlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundColour: UIView!
    @IBOutlet weak var nestedTableView: NestedUITableView!
    @IBOutlet weak var aboutPlayerLabel: UILabel!

    var indexPath: IndexPath?
    var aboutUs : [Rating]?

    func populateData(aboutUs: [Rating]?, aboutText:String) -> Void {
        self.aboutUs = aboutUs
        self.aboutPlayerLabel.text = aboutText
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



extension AboutPlayerTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 31.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aboutUs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NestedTableViewCell", for: indexPath) as! NestedTableViewCell
        cell.populateData(attribute: aboutUs?[indexPath.row])
        return cell
    }
}
