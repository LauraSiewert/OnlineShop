//
//  ArticelOverviewViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 16.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

class ArticelOverviewViewController: UIViewController {

    var articels : [Articel] = [] //Array für Artikel
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var contentText : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createArticels()
        self.fetchArticels()

        // Do any additional setup after loading the view.
    }
    
    func createArticels (){
        let articelEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Articel", in: self.appDelegate.coreDataStack.managedObjectContext)
        //        let subCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "SubCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if articelEntity != nil {
            let articel1: Articel =
                Articel(entity: articelEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            articel1.articelName = "A1"
            articel1.articelAmount = "1"
        }
    }
    
    func fetchArticels() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Articel")
        // fetchRequest.predicate = NSPredicate(format: "mainCategory.subCategories==false") ist wie eine SELECT Abfrage
        do {
            if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedArticels: [Articel]? = results as? [Articel]
                if fetchedArticels != nil {
                    self.articels = fetchedArticels!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
}
