//
//  DesktopViewController.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class DesktopViewController: UIViewController {
    
    @IBOutlet weak var consoleButton: UIButton!
    @IBOutlet weak var internetExplorerButton: UIButton!
    @IBOutlet weak var readMeButton: UIButton!
    @IBOutlet weak var crackButton: UIButton!
    
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var timebarImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var startMenuView: UIView!
    
    var mechanicalTapSystem = mechanicalTap()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.startClock()
    }
    
    private func setupView() {
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        
        self.barImageView.backgroundColor = .clear
        self.barImageView.image = UIImage(named: "bar")!
        
        self.startButton.backgroundColor = .clear
        
        self.timebarImageView.backgroundColor = .clear
        self.timebarImageView.image = UIImage(named: "timebar")!
        
        self.consoleButton.backgroundColor = .clear
        self.internetExplorerButton.backgroundColor = .clear
        self.readMeButton.backgroundColor = .clear
        self.crackButton.backgroundColor = .clear
        
        self.setDefaultButtonBackground()
    }
    
    private func setDefaultButtonBackground() {
        self.consoleButton.setBackgroundImage(UIImage(named: "console_normal"), for: .normal)
        self.internetExplorerButton.setBackgroundImage(UIImage(named: "internet_normal"), for: .normal)
        self.readMeButton.setBackgroundImage(UIImage(named: "readme_normal"), for: .normal)
        self.crackButton.setBackgroundImage(UIImage(named: "crack_normal"), for: .normal)
        self.startButton.setBackgroundImage(UIImage(named: "start_normal"), for: .normal)
        
        self.startMenuView.isHidden = true
        self.startMenuView.isUserInteractionEnabled = false
    }
    
    private func setSelectedButtonBackground(buttonTag: Int) {
        self.setDefaultButtonBackground()
        
        switch buttonTag {
        case 0:
            self.consoleButton.setBackgroundImage(UIImage(named: "console_pressed"), for: .normal)
        case 1:
            self.internetExplorerButton.setBackgroundImage(UIImage(named: "internet_pressed"), for: .normal)
        case 2:
            self.readMeButton.setBackgroundImage(UIImage(named: "readme_pressed"), for: .normal)
        case 3:
            self.crackButton.setBackgroundImage(UIImage(named: "crack_pressed"), for: .normal)
        case 4:
            self.startButton.setBackgroundImage(UIImage(named: "start_pressed"), for: .normal)
            self.startMenuView.isHidden = false
            self.startMenuView.isUserInteractionEnabled = true
            
        default:
            break
        }
    }
    
    private func startClock() {
        self.clockLabel.text = self.getHour()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.clockLabel.text = self.getHour()
        }
    }
    
    private func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        AudioManager.shared.play(soundEffect: .start)
        HapticFeedbackCenter.shared.impact.impactOccurred()
        
        self.setSelectedButtonBackground(buttonTag: sender.tag)
        self.mechanicalTapSystem.addTap(buttonTag: sender.tag)
        
        if [5,6,7,8,9,10].contains(sender.tag) {
            print("Vai acessar o botão de tag: \(mechanicalTapSystem.tappedTag)")
            self.decideSegueRoute()
        }
        
        if mechanicalTapSystem.isDoubleTap {
            print("Vai acessar o botão de tag: \(mechanicalTapSystem.tappedTag)")
            self.decideSegueRoute()
        }
    }
    
    @IBAction func onEmpty(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        self.setDefaultButtonBackground()
    }
    
    func decideSegueRoute() {
        switch self.mechanicalTapSystem.tappedTag {
        case 0, 5:
            self.performSegue(withIdentifier: Model.instance.isConsoleCracked ? "segueConsole" : "segueAlert", sender: nil)
        case 1, 6:
            self.performSegue(withIdentifier: "segueAlert", sender: nil)
        case 2, 7:
            self.performSegue(withIdentifier: "segueNotepad", sender: nil)
        case 3, 8:
            self.performSegue(withIdentifier: "segueCrack", sender: nil)
        case 9, 10:
            self.performSegue(withIdentifier: "segueAlert", sender: nil)
        default:
            print("Warning - No segue detected")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAlert" {
            if let vc = segue.destination as? AlertViewController {
                if mechanicalTapSystem.tappedTag == 0 || mechanicalTapSystem.tappedTag == 5 {
                    vc.content = AlertContent(actionText: "Close", alertType: .error, description: "License checkout timed out.", content: "A licensing error occurred while the user was attempting to connect (Licensing timed out).")
                } else if (mechanicalTapSystem.tappedTag == 1 || mechanicalTapSystem.tappedTag == 6) && !Model.instance.hasInternetExplorerAccess{
                    vc.content = AlertContent(actionText: "Close", alertType: .warning, description: "File Access Denied", content: "You'll need to provide administrator permission to access Internet Explorer.")
                } else {
                    vc.content = AlertContent(actionText: "Close", alertType: .warning, description: "Work in Progress", content: "This feature has't been developed yet. Wait for it :)")
                }
            }
        }
    }
    
}

//if segue.identifier == "GoToCardDetailSegue" {
//    if let vc = segue.destination as? CardDetailViewController {
//        if self.myCard {
//            vc.figurinhaAtual = Model.shared.figurinhaAtual
//        } else {
//            vc.figurinhaAtual = Model.shared.figurinhas[self.indexCard]
//        }
//
//    }
//}
