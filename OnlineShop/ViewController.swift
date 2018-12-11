//
//  ViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var mainCategories : [MainCategory] = [] //Array für MainCategories
    var subCategories: [SubCategory] = [] // Array für SubCategories
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
      var childManagedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.childManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.childManagedObjectContext?.parent = self.appDelegate.coreDataStack.managedObjectContext
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        if firstStart == nil {
            self.createDemoData()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        self.fetchMainCategory()
        myTableView.separatorStyle = .none
    }
    
    
    //Hauptkategorien erstellen
    func createDemoData(){
        let mainCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "MainCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
//        let subCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "SubCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if mainCategoryEntity != nil {
            let mainCategory1: MainCategory =
            MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory1.mainCategoryName = "Neuheiten"
            mainCategory1.mainCategoryImage = #imageLiteral(resourceName: "becher-blume-brauen-1050294").toString()
            
            let mainCategory2: MainCategory =
            MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory2.mainCategoryName = "Kleidung"
            mainCategory2.mainCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            
            self.appDelegate.coreDataStack.saveContext()
        }
    }
    
    
    //Hol die Daten
    func fetchMainCategory() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MainCategory")
       // fetchRequest.predicate = NSPredicate(format: "mainCategory.subCategories==false") ist wie eine SELECT Abfrage
        do {
                if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                    let fetchedMainCategories: [MainCategory]? = results as? [MainCategory]
                    if fetchedMainCategories != nil {
                        self.mainCategories = fetchedMainCategories!
                    }
                }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
    //TableView und Zellen erstellen
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainCategories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 220
        var cell : MainCategoriesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "mainCell") as? MainCategoriesTableViewCell
        
        if cell == nil {
            cell = MainCategoriesTableViewCell(style: .default, reuseIdentifier: "mainCell")
        }
        
        let mainCategory : MainCategory = mainCategories[indexPath.row]
        cell!.setMainCategory(preview: mainCategory)
        cell!.delegate = self as? MainCategoryDelegate
        cell!.selectionStyle = .none
        return cell!
    }
}

//Cast from Image to String
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

