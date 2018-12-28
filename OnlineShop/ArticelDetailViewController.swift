//
//  ArticelDetailViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 20.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

class ArticelDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var articels : [Articel] = []
    var articel : Articel?
    var subCategory : SubCategory?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var myDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchArticels()
        
        self.myDetailTableView.reloadData()
        
    }
    
    //MARK: Daten für articels holen
    func fetchArticels() {
        guard let articel = articel else { return }
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Articel")
        //fetchRequest.predicate = NSPredicate(format: "articel == %@", articel)
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
    
    
    //MARK: TableViews füllen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            myDetailTableView.rowHeight = 300
            let cell : ArticelImageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "articelImage", for: indexPath) as? ArticelImageTableViewCell
            let articel = articels[indexPath.row]
            cell!.setArticelImage(preview: articel)
            cell!.selectionStyle = .none
            return cell!
        }
        else {
            myDetailTableView.rowHeight = 200
            let cell : ArticelDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "articelDetail", for: indexPath) as? ArticelDetailTableViewCell
            let articel = articels[indexPath.row]
            cell!.setArticelDetail(preview: articel)
            cell!.selectionStyle = .none
            return cell!
        }
        
    }
}
