//
//  CustomTabBar.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import Foundation
import UIKit
class CustomTabBar:UITabBar{
   
    
    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        //self.barTintColor = .white
        //self.isTranslucent = false
        //setColors()
    }
    
    func setColors(){
        
    if #available(iOS 15.0, *) {
            
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            
            tabBarAppearance.backgroundColor = .white
            
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.accentColor()]
            
            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
            self.standardAppearance = tabBarAppearance
        self.scrollEdgeAppearance = tabBarAppearance
            
        }
        else{
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  Colors.accentColor()]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.red]
                self.standardAppearance = appearance
            
        }
    }
}
