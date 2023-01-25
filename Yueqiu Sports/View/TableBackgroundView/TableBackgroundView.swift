//
//  TableBackgroundView.swift
//  SportScore
//
//  Created by Abdullah on 19/01/2023.
//

import UIKit

class TableBackgroundView : UIView {
 
    @IBOutlet weak var contentView : UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TableBackgroundView", owner: self, options: nil)
        contentView.fixInView(self)
    }
}
