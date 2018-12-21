//
//  ViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainCategories : [MainCategory] = [] //Array für MainCategories
    var news : [News] = [] // Array für Neuheiten
   
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var childManagedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.childManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.childManagedObjectContext?.parent = self.appDelegate.coreDataStack.managedObjectContext

        news = createNews()
        self.fetchMainCategory()
        
        //keine Trennlinien in der TableView
        myTableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Stea", size: 20)!]
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
    
    
    //MARK: Übergabe der Daten an den nächsten ViewController
    private var selectedMainCategory : MainCategory?
    private var selectedNews : News?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMainCategory = mainCategories[indexPath.row-2]
        //selectedNews = news [indexPath.row]
        //Notiz an Sandra: möchtest du Neuheiten testen kommentiere die erste Zeile aus
        //möchtest du die Kategorien testen Kommentiere die 2. Zeile aus
    }

    
    //MARK: Was passiert, wenn man auf die Kategorien oder Neuheiten klickt
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Funktion für SubCategoryView
        if segue.identifier == "subCategories" {
            let detailVC: SubCategoryViewController? = segue.destination as? SubCategoryViewController
            
            //Übergabe der Daten für den nächsten ViewController
            let selectedIndex = self.myTableView.indexPathForSelectedRow!.row - 2
            
            selectedMainCategory = self.mainCategories[selectedIndex]
            
            detailVC?.mainCategory = selectedMainCategory
            
            //Navigation Title für nächsten ViewController setzen
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
            
            //Übergabe der Daten für den nächsten ViewController
            let selectedIndex = self.myTableView.indexPathForSelectedRow!.row
            
            selectedNews = self.news[selectedIndex]
            
            
            detailVC?.news = selectedNews
            //Navigation Title für nächsten ViewController setzen
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

