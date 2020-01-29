//
//  ShutdownViewController.swift
//  otaviOS
//
//  Created by Otavio on 29/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class ShutdownViewController: UIViewController {
    
    var isRestart: Bool?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioManager.shared.play(soundEffect: .shutdown)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
            self.decideRoute()
            Timer.invalidate()
        }
    }

    private func decideRoute() {
        if isRestart ?? false {
            self.restartRoute()
        } else {
            self.shutdownRoute()
        }
    }
    
    private func restartRoute() {
        self.performSegue(withIdentifier: "segueStartup", sender: nil)
    }
    
    private func shutdownRoute() {
        exit(0)
    }
}
