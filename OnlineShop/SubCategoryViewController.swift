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
    
    var mainCategory : MainCategory?
    
    var subCategories: [SubCategory] = [] // Array für SubCategories
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var mySubCategoryView: UIView!
    var contentText: String? //zum ändern des Titels der NavigationBar
    
    
    @IBOutlet weak var mySubCategoryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Daten holen
        self.fetchSubCategory()
        
        // Seperator ausstellen
        mySubCategoryTableView.separatorStyle = .none
        
        //TableView neu laden, damit die passenden Daten angezeigt werden
        self.mySubCategoryTableView.reloadData()
    }

    
    //MARK: Hol die Daten für die SubCategories
    func fetchSubCategory() {
        guard let mainCategory = mainCategory else { return }
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubCategory")
        fetchRequest.predicate = NSPredicate(format: "mainCategory == %@", mainCategory)
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
        let cell : SubCategoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "subCategory", for: indexPath) as? SubCategoryTableViewCell
        let subCategory = subCategories[indexPath.row]
        cell!.setSubCategory(preview: subCategory)
        cell!.selectionStyle = .none
        return cell!
    }
}

