//
//  NotepadViewController.swift
//  otaviOS
//
//  Created by Otavio on 24/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class NotepadViewController: UIViewController {
    
    @IBOutlet weak var notepadView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClose(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        AudioManager.shared.play(soundEffect: .start)
        self.dismiss(animated: false, completion: nil)
    }
    

}
