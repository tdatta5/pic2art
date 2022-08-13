//
//  HomePageViewController.swift
//  Pic2Art
//
//  Created by Tanya Datta on 8/10/22.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        
    }
    
    @IBAction func takePicture(_ sender: Any) {
    }
    
}

