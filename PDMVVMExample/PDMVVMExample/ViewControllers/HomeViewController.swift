//
//  ViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 02/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func tableViewAction(sender: UIButton) {
        let vc = TableViewController.create()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func scrollViewAction(sender: UIButton) {
        let vc = ScrollViewController.create()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func collectionViewAction(sender: UIButton) {
        let vc = CollectionViewController.create()
        navigationController?.pushViewController(vc, animated: true)
    }

}

