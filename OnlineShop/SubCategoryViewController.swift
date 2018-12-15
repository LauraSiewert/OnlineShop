//
//  SubCategoryViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 15.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

protocol SubCategoryDelegate {
//    func getInvitedFriendsCount() -> Int
//    func getInvitedFriendForRowAtIndexPath(indexPath: IndexPath) -> FriendEntity
//    func uninviteFriendAtIndexPath(indexPath: IndexPath)
}

class SubCategoryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    var delegate: SubCategoryDelegate?
    
    var subCategories: [SubCategory] = [] // Array für SubCategories
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contentText: String? //zum ändern des Titels der NavigationBar
    
    
    @IBOutlet weak var mySubCategoryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        var name : String?
        if firstStart == nil {
            self.createSubCategories()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        
        self.fetchSubCategory()
        mySubCategoryTableView.separatorStyle = .none
        
//        if self.name != nil {
//            self.title = name!
//        }
//        
        //Titel der NavigationBar setzten
//        if contentText != nil {
//            navigationItem.title = contentText!
//        }
    }
    
    //MARK: Inhalt für Subcategory erstellen
    func createSubCategories(){
    let subCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "SubCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if subCategoryEntity != nil {
            let subCategory1: SubCategory =
               SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
           subCategory1.subCategoryName = "ONESIE"
           subCategory1.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory1.mainCategory?.mainCategoryName = "KLEIDUNG"
            
            let subCategory2: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory2.subCategoryName = "KUSCHELSOCKEN"
            subCategory2.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory2.mainCategory?.mainCategoryName = "KLEIDUNG"
            
            let subCategory3: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory3.subCategoryName = "PYJAMAS"
            subCategory3.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory3.mainCategory?.mainCategoryName = "KLEIDUNG"
            
            let subCategory4: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory4.subCategoryName = "TEE & KAKAO"
            subCategory4.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory4.mainCategory?.mainCategoryName = "SCHLAFHILFEN"
            
            let subCategory5: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory5.subCategoryName = "CDS"
            subCategory5.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory5.mainCategory?.mainCategoryName = "SCHLAFHILFEN"
            
            
            let subCategory6: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory6.subCategoryName = "TABLETTEN"
            subCategory6.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory6.mainCategory?.mainCategoryName = "SCHLAFHILFEN"
            
            let subCategory7: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory7.subCategoryName = "DECKEN"
            subCategory7.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory7.mainCategory?.mainCategoryName = "DECKEN & KISSEN"
            
            let subCategory8: SubCategory =
                SubCategory(entity: subCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            subCategory8.subCategoryName = "KISSEN"
            subCategory8.subCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            subCategory5.mainCategory?.mainCategoryName = "DECKEN & KISSEN"
            
            self.appDelegate.coreDataStack.saveContext()
        }
    }
    
    //MARK: Hol die Daten für die SubCategories
    func fetchSubCategory() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubCategory")
        do {
            if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedSubCategories: [SubCategory]? = results as? [SubCategory]
                if fetchedSubCategories != nil {
                    self.subCategories = fetchedSubCategories!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
    //MARK: TableView und Zellen erstellen
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCategories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            mySubCategoryTableView.rowHeight = 200
            let subCategory = subCategories[indexPath.row]
            let cell : SubCategoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "subCategory", for: indexPath) as? SubCategoryTableViewCell
            cell!.setSubCategory(preview: subCategory)
            cell!.selectionStyle = .none
            return cell!
    }
}

