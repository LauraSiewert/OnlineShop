//
//  ViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData

protocol MainCategoryDelegate {
    func didChooseMainCategory(subCategory: SubCategory)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var mainCategories : [MainCategory] = [] //Array für MainCategories
    var news : [News] = [] // Array für Neuheiten
    var choosedMainCategoryDelegate : MainCategoryDelegate!
   
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var childManagedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.childManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.childManagedObjectContext?.parent = self.appDelegate.coreDataStack.managedObjectContext
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        if firstStart == nil {
            self.createMainCategories()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        news = createNews()
        self.fetchMainCategory()
        
        //keine Trennlinien in der TableView
        myTableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Stea", size: 20)!]
    }
    
    
    //MARK: Hauptkategorien erstellen
    func createMainCategories(){
        let mainCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "MainCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
//        let subCategoryEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "SubCategory", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if mainCategoryEntity != nil {
            let mainCategory2: MainCategory =
            MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory2.mainCategoryName = "KLEIDUNG"
            mainCategory2.mainCategoryImage = #imageLiteral(resourceName: "mainCategory2").toString()
            mainCategory2.subCategories = ["ONESIE", "KUSCHELSOCKEN", "PYJAMAS"]
            
            let mainCategory3: MainCategory =
                MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory3.mainCategoryName = "BETTWARE"
            mainCategory3.mainCategoryImage = #imageLiteral(resourceName: "bett-design-drinnen-1329711").toString()
            mainCategory3.subCategories = ["DECKEN", "KISSEN"]
            
            let mainCategory4: MainCategory =
                MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory4.mainCategoryName = "SCHLAFHILFEN"
            mainCategory4.mainCategoryImage = #imageLiteral(resourceName: "mainCategory1").toString()
            mainCategory3.subCategories = ["TABLETTEN", "CDS", "TEE & KAKAO"]
            
            let mainCategory5: MainCategory =
                MainCategory(entity: mainCategoryEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            mainCategory5.mainCategoryName = "SCHLAFMASKEN"
            mainCategory5.mainCategoryImage = #imageLiteral(resourceName: "mainCategory1").toString()
            
            self.appDelegate.coreDataStack.saveContext()
        }
    }
    
    //MARK: Inhalt für Zelle Neuheiten erzeugen
    func createNews()-> [News]{
        var tempNews : [News] = []
        let news1 = News(newsImage: #imageLiteral(resourceName: "becher-blume-brauen-1050294"), newsLabel: "NEUHEITEN")

        tempNews.append(news1)
        
        return tempNews
    }
    
    
    //MARK: Hol die Daten für die MainCategories
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
    
    //MARK: TableView und Zellen erstellen
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainCategories.count + news.count+1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // NeuheitenZelle
        if (indexPath.row==0){
            myTableView.rowHeight = 220
            let new = news[indexPath.row]
            let cell : NewsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as? NewsTableViewCell
            cell!.setNews(preview: new)
            cell!.selectionStyle = .none
            return cell!
        }
        //Leere Zelle als Teiler
        else if (indexPath.row==1){
            myTableView.rowHeight = 15
            let cell = tableView.dequeueReusableCell(withIdentifier: "space", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        //Hautpkategorien Zelle
        else{
            myTableView.rowHeight = 200
            let mainCategory = mainCategories[indexPath.row-2]
            let cell : MainCategoriesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "mainCategory", for: indexPath) as? MainCategoriesTableViewCell
            cell!.setMainCategory(preview: mainCategory)
            cell!.selectionStyle = .none
            return cell!
        }
    }

    
    //MARK: Was passiert, wenn man auf die Kategorien oder Neuheiten klickt
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Funktion für SubCategoryView
        if segue.identifier == "subCategories" {
            let detailVC: SubCategoryViewController? = segue.destination as? SubCategoryViewController
            let cell: UITableViewCell? = sender as? UITableViewCell
            
            if cell != nil && detailVC != nil {
                let indexPath: IndexPath? = self.myTableView.indexPath(for: cell!)
                if indexPath != nil {
                    let mainCategory: MainCategory = mainCategories[indexPath!.row-2]
                    detailVC!.navigationItem.title = mainCategory.mainCategoryName
                }
            }
           
        }
        
       // Funktion für NewsView
        if segue.identifier == "news" {
            let detailVC: ArticelOverviewViewController? = segue.destination as? ArticelOverviewViewController
            let cell: NewsTableViewCell? = sender as? NewsTableViewCell

            if cell != nil && detailVC != nil {
                let indexPath: IndexPath? = self.myTableView.indexPath(for: cell!)
                if indexPath != nil {
                    let newsName: News = news[indexPath!.section]
                    detailVC!.navigationItem.title = newsName.newsLabel
                }
            }
        }
    }
    
    
    
    
    
    
    
}


//MARK: Cast from Image to String
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

