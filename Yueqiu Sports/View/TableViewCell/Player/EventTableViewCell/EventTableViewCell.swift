//
//  AboutPlayerTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundColour: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var nestedTableView: NestedUITableView!
    @IBOutlet weak var eventImageView: UIImageView!

    var activeTextField : UITextField?
    var matches : [PlayerMatches]?
    
    func populateData(matches:[PlayerMatches]?, title:String = "", imageUrl: String) -> Void {
        self.matches = matches
        self.labelTitle.text = title
                
        eventImageView.setImage(with: imageUrl, placeholder: nil)
        
        self.contentView.layoutIfNeeded()
        nestedTableView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib = UINib(nibName: "EventMatchTableViewCell", bundle: nil)
        nestedTableView.register(nib, forCellReuseIdentifier: "EventMatchTableViewCell")
        nestedTableView.delegate = self
        nestedTableView.dataSource = self
    }
}



extension EventTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventMatchTableViewCell", for: indexPath) as! EventMatchTableViewCell
        cell.populateData(match: matches?[indexPath.row])
        cell.contentView.layoutIfNeeded()
        cell.layoutIfNeeded()
        return cell
    }
}
