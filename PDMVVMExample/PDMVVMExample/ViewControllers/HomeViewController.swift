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
    
    @IBAction func start(sender: UIButton) {
        let vc = MainViewController.create()
        navigationController?.pushViewController(vc, animated: true)
    }

}

