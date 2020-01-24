//
//  StartupViewController.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (Timer) in
            self.performSegue(withIdentifier: "segueDesktop", sender: nil)
            Timer.invalidate()
        }
    }

}
