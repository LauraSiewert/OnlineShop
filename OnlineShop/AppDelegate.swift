//
//  AppDelegate.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coreDataStack: CoreDataStack = CoreDataStack()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        if firstStart == nil {
            self.createKatalog()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: Funktionen, um die Objekte leichter zu erstellen
    
    private func createMainEntity(entityDescription: NSEntityDescription, name: String, imageName: String?) -> MainCategory {
        
        let mainCategory
            : MainCategory =
            MainCategory(entity: entityDescription, insertInto: self.coreDataStack.managedObjectContext)
        mainCategory.mainCategoryName = name
        mainCategory.mainCategoryImage = imageName

        return mainCategory
    }

    private func createSubEntitiy(entityDescription: NSEntityDescription, name: String, imageName: String?, mainCategory: MainCategory) -> SubCategory {
        
        let subCategory
            : SubCategory =
            SubCategory(entity: entityDescription, insertInto: self.coreDataStack.managedObjectContext)
        subCategory.subCategoryName = name
        subCategory.subCategoryImage = imageName
        subCategory.mainCategory = mainCategory
        
        return subCategory
    }

    //MARK: Objekte für die Datenbank erstellen
    
    func createKatalog(){

        guard let mainCategoryEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "MainCategory", in: self.coreDataStack.managedObjectContext),
            let subCategoryEntity: NSEntityDescription =  NSEntityDescription.entity(forEntityName: "SubCategory", in: self.coreDataStack.managedObjectContext) else {
                return
        }
        
        let mainCategory1: MainCategory = createMainEntity(entityDescription: mainCategoryEntity, name: "KLEIDUNG", imageName:  #imageLiteral(resourceName: "mainCategory2").toString() )
        let subsFor1 = [("ONESIE",  #imageLiteral(resourceName: "mainCategory2").toString()), ("KUSCHELSOCKEN",  #imageLiteral(resourceName: "mainCategory2").toString()), ("PYJAMAS",  #imageLiteral(resourceName: "mainCategory2").toString())].map{(name, imageName) in
            return createSubEntitiy(entityDescription: subCategoryEntity, name: name, imageName: imageName , mainCategory: mainCategory1)
        }
        
        let mainCategory2: MainCategory = createMainEntity(entityDescription: mainCategoryEntity, name: "BETTWARE", imageName:  #imageLiteral(resourceName: "mainCategory2").toString())
        let subsFor2 = [("DECKEN",  #imageLiteral(resourceName: "mainCategory2").toString()), ("KISSEN",  #imageLiteral(resourceName: "mainCategory2").toString())].map{(name, imageName) in
            return createSubEntitiy(entityDescription: subCategoryEntity, name: name, imageName: imageName , mainCategory: mainCategory2)
        }
        
        let mainCategory3: MainCategory = createMainEntity(entityDescription: mainCategoryEntity, name: "SCHLAFMASKEN", imageName: #imageLiteral(resourceName: "mainCategory2").toString())
       
        let mainCategory4: MainCategory = createMainEntity(entityDescription: mainCategoryEntity, name: "SCHLAFHILFEN", imageName:  #imageLiteral(resourceName: "mainCategory2").toString())
        let subsFor4 = [("KAKAO & TEE",  #imageLiteral(resourceName: "mainCategory2").toString()), ("CDS",  #imageLiteral(resourceName: "mainCategory2").toString())].map{(name, imageName) in
            return createSubEntitiy(entityDescription: subCategoryEntity, name: name, imageName: imageName , mainCategory: mainCategory4)
        }
        
        self.coreDataStack.saveContext()
    }
}

