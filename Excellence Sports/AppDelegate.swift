//
//  AppDelegate.swift
//  Excellence Sports
//
//  Created by Remya on 12/24/22.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import MOLH


@main
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if AppPreferences.getLaunchDate().count == 0{
            AppPreferences.setLaunchDate(date: "31-12-2022")
        }
        IQKeyboardManager.shared.enable = true
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        setRoot()
        // Override point for customization after application launch.
        return true
    }
    
    func setRoot(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchesViewController")
        window?.rootViewController = vc
        
    }
    
    func reset() {
        
        setupLaunch()
    }
    
    func setupLaunch(){
        //if AppPreferences.getIsFirstRun(){
            Utility.gotoHome()
            if Utility.getSettingsDateDiff() >= 3{
            Utility.callURlDetailsAPI()
            }
           
//        }
//        else{
//            AppPreferences.setIsFirstRun(value: true)
//            let initVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = initVC
//        }
        
    }
    
   
    func getPhoneLanguage() -> String{
        var locale = NSLocale.current.languageCode!
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? ""
        if countryCode == "CN"{
            locale = "zh"
        }
        return locale
        
    }


   

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Excellence_Sports")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

