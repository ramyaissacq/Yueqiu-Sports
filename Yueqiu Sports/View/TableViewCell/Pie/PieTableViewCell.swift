//
//  PieTableViewCell.swift
//  Excellence Sports
//
//  Created by Remya on 1/16/23.
//

import UIKit
import Charts

class PieTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateChartData(values:[Double])  {
       //let xVal = (UIScreen.main.bounds.width - (330 + 60))/2

        let chart = PieChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 350))
        // 2. generate chart data entries
        let track = ["Home team wins".localized, "Away team wins".localized, "Draws".localized]
    

        var entries = [PieChartDataEntry]()
        for (index, value) in values.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = track[index]
            entries.append( entry)
        }

        // 3. chart setup
        let set = PieChartDataSet( entries: entries, label: "")
        // this is custom extension method. Download the code for more details.
        let colors: [UIColor] = [Colors.pieHomeColor(),Colors.pieAwayColor(),Colors.pieDrawsColor()]

        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true

//        let d = Description()
//        d.text = "iOSCharts.io"
//        chart.chartDescription = d
       // chart.centerText = "Pie Chart"
        chart.holeRadiusPercent = 0.2
        chart.transparentCircleColor = UIColor.clear
        self.backView.addSubview(chart)

    }
    
}
