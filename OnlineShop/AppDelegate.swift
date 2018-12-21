//
//  AppDelegate.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coreDataStack: CoreDataStack = CoreDataStack()
    
    let coreLocationManager : CLLocationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        if firstStart == nil {
            self.createKatalog()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
    
        coreLocationManager.requestWhenInUseAuthorization()
        
        
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
    
    private func createArticelEntity (entityDescription: NSEntityDescription, name: String, imageName: String?, amount: String?, description: String, price: Double, size: String, color: String, subCategory: SubCategory) -> Articel{
        
        let articel : Articel = Articel(entity: entityDescription, insertInto: self.coreDataStack.managedObjectContext)
        articel.articelName = name
        articel.articelImage = imageName
        articel.articelAmount = amount
        articel.articelDescription = description
        articel.articelPrice = price
        articel.articelSize = size
        articel.articelColor = color
        articel.subCategory = subCategory
        
        return articel
    }
    
    //MARK: Objekte für die Datenbank erstellen
    
    func createKatalog(){

        guard let mainCategoryEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "MainCategory", in: self.coreDataStack.managedObjectContext),
            let subCategoryEntity: NSEntityDescription =  NSEntityDescription.entity(forEntityName: "SubCategory", in: self.coreDataStack.managedObjectContext),
            let articelEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Articel", in: self.coreDataStack.managedObjectContext)
        else {
                return
        }
        
        let mainCategory1: MainCategory = createMainEntity(entityDescription: mainCategoryEntity, name: "KLEIDUNG", imageName:  #imageLiteral(resourceName: "mainCategory2").toString() )
        let subsFor1 = [("ONESIES",  #imageLiteral(resourceName: "mainCategory2").toString()), ("KUSCHELSOCKEN",  #imageLiteral(resourceName: "mainCategory2").toString()), ("PYJAMAS",  #imageLiteral(resourceName: "mainCategory2").toString())].map{(name, imageName) in
            return createSubEntitiy(entityDescription: subCategoryEntity, name: name, imageName: imageName , mainCategory: mainCategory1)
        }
        // Artikel in der Unterkategorie Onesie
        let articel1For1 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Tieronesie mit Kapuze" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Der süße Tieronesie aus superkuscheligem Flannel hält auch bei kälteren Temperaturen warm und ist äußerlich ein toller Hingucker. Sowohl für Zuhause, als auch für die nächste Kostümparty geeignet!", price: 25.99, size: "XS,S,M,L,XL" , color: "Lemour, Einhorn, Giraffe", subCategory: subsFor1[0])
        let articel2For1 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Onesie mit Kapuze" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Moderner, sportlicher Onesie mit Kapuze. Durch sein weiches Innenfutter hält auch an den kältesten Wintertagen warm und sorgt für ein optimales Tragegefühl", price: 19.99, size: "XS,S,M,L,XL" , color: "Rosa, Lila, Grau", subCategory: subsFor1[0])
         let articel3For1 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Sportlicher Onesie" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Sportlicher Onesie mit Kapuze. Dieser Onesie sieht nicht nur gut aus, er hält auch optimal warm und bietet einen angenehmen Tragekomfort", price: 15.99, size: "XS,S,M,L,XL" , color: "schwarz, rosa, weiß", subCategory: subsFor1[0])
        
        //Artikel in der Unterkategorie Kuschelsocken
        let articel1For2 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Weihnachtliche Kuschelsocken" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Süße Wohlfühlsocken mit super weichem Teddyfutter – ideal für Zuhause und im Bett gegen kalte Füße", price: 9.99, size: "Onesize" , color: "grau, grün, rot", subCategory: subsFor1[1])
         let articel2For2 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Warme Kuschelsocken" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Super weiches, flauschiges & entspannendes Wohlgefühl und eine angenehme Wärme für die Füße. Perfekt für den Alltag oder auch zum Schlafen.", price: 5.99, size: "Onesize" , color: "rosa, schwarz", subCategory: subsFor1[1])
         let articel3For2 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Kuschelsocken im Doppepack" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Super weiche Kuschelsocken in zwei verschiedenen Farben. Wärmen die Füße und sorgen für ein angenehmes Tragegefühl.", price: 3.99, size: "Onesize" , color: "creme, rosa/rot, dunkelblau/hellblau", subCategory: subsFor1[1])
        
        //Artikel in der Unterkategorie Pyjamas
        let articel1For3 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Pyjama mit Hundeaufdruck" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Klassisches Pyjama-Set auf feinstem Satin mit süßen Hundeaufdruck. Oberteil mit klassischem Hemdkragen, praktische Seitentaschen und Knopfleiste vorn, lange Hose mit geradem Bein und Tunnelzug. ", price: 19.99, size: "Onesize" , color: "weiß, dunkelgrün", subCategory: subsFor1[2])
        let articel2For3 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Klassischer Pyjama" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Zweiteiliger Schlafanzug,Oberteil mit klassischem Hemdkragen, praktische Seitentaschen und Knopfleiste vorn, lange Hose mit geradem Bein und Tunnelzug. Angenehmes Tragefühl und auch perfekt für weniger kalte Tage.", price: 9.99, size: "XS, S, M, L, XL" , color: "Dunkelrot, Schwarz", subCategory: subsFor1[2])
        let articel3For3 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Pyjama mit Tieraufdruck" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Komplett aus besonders hochwertiger und atmungsaktiver Baumwolle. Durch sein warmes Innenfutter wärmt der Pyjama optimal und sorgt für einen angenehmen Schlaf.", price: 15.99, size: "XS, S, M, L, XL" , color: "rosa, türkis, grau", subCategory: subsFor1[2])
        let articel4For3 : Articel = createArticelEntity(entityDescription: articelEntity, name: "Schlichter Pyjama" , imageName: #imageLiteral(resourceName: "mainCategory2").toString(), amount: "0", description: "Schlichter Zweiteiler aus 100% Baumwolle. Ist durch sein einfaches, aber hochwertiges Material sowohl für den Herbst, als auch für den Winter geeignet.", price: 8.99, size: "XS, S, M, L, XL" , color: "Rosa, Blau, dunkelblau/hellblau", subCategory: subsFor1[2])
        
        
        
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

