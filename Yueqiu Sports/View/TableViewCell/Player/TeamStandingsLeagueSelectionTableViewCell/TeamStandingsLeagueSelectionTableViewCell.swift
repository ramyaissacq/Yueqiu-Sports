//
//  ArithmeticMeanNestedTableViewCell.swift
//  SportScore
//
//  Created by Abdullah on 16/01/2023.
//

import UIKit

class TeamStandingsLeagueSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelStatName: UILabel!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    var selectedIndex : Int = 0

    var didSelectItemAtIndex:((Int) -> Void)?
    
    let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont(name: ApplicationFonts.Regular.rawValue, size: 14.0)!,
                                         NSAttributedString.Key.foregroundColor: Colors.accentColor()] as [NSAttributedString.Key : Any]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.underlineSelected = true
//        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.fixedSegmentWidth = false
        segmentedControl.setTitleTextAttributes(largerRedTextSelectAttributes, for: .selected)
    }


    func populateData(stats: [String]?) -> Void {
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.underlineSelected = true
        segmentedControl.fixedSegmentWidth = false
        segmentedControl.underlineHeight = 3.0
        segmentedControl.selectedSegmentIndex = selectedIndex
        segmentedControl.tintColor = Colors.accentColor()
        segmentedControl.selectedSegmentContentColor = Colors.accentColor()
        segmentedControl.setTitleTextAttributes(largerRedTextSelectAttributes, for: .selected)
        
        if segmentedControl.numberOfSegments == 0 {
            
            for index in (stats?.indices)! {
                segmentedControl.insertSegment(withTitle: stats?[index] ?? "", at: index)
            }
        }
        
        segmentedControl.addTarget(self, action: #selector(TeamStandingsLeagueSelectionTableViewCell.segmentSelected(sender:)), for: .valueChanged)
    }
    
    func selectIndexAt(index: Int) {
//        segmentedControl.selectedSegmentIndex = index
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        didSelectItemAtIndex?(sender.selectedSegmentIndex)
    }
}
