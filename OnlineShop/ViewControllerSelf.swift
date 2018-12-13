//
//  ViewControllerSelf.swift
//  OnlineShop
//
//  Created by Sandra Schwarz on 13.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class ViewControllerSelf: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Stea", size: 20)!]

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
