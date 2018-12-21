//
//  ArticelOverviewViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 16.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

class ArticelOverviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var articels : [Articel] = [] //Array für Artikel
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var contentText : String?
    
    var subCategory : SubCategory? 
    
    var news : News?
   
    @IBOutlet weak var myArticelCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchArticels()
        self.myArticelCollection.reloadData()
    }
    
    
    func fetchArticels() {
        guard let subCategory = subCategory else { return }
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Articel")
        fetchRequest.predicate = NSPredicate(format: "subCategory == %@", subCategory)
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.articels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArticelOverviewCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "articel", for: indexPath) as? ArticelOverviewCollectionViewCell
        let articel = articels[indexPath.row]
        cell!.setArticel(preview: articel)
        return cell!
    }
    
    //MARK: Was passiert, wenn ich auf einen Artikel klicke
    var selectedArticel : Articel?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticel = articels[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Funktion für SubCategoryView
        if segue.identifier == "toArticelDetail" {
            
            let detailVC: ArticelDetailViewController? = segue.destination as? ArticelDetailViewController
            let cell: UICollectionViewCell? = sender as? UICollectionViewCell
            
            //Übergabe der Daten für den nächsten ViewController
            let selectedIndex = self.myArticelCollection.indexPath(for: cell!)
            
            if let indexPath = selectedIndex {
                selectedArticel = self.articels[indexPath.row]
                detailVC?.articel = selectedArticel
//                let post = articels[indexPath.row]
//                detailVC!.articel = post
            }
            
            //Navigation Title für nächsten ViewController setzen
            if cell != nil && detailVC != nil {
                let indexPath: IndexPath? = self.myArticelCollection.indexPath(for: cell!)
                if indexPath != nil {
                    let articel: Articel = articels[indexPath!.row]
                    detailVC!.navigationItem.title = articel.articelName
                }
            }
        }
    }
}


