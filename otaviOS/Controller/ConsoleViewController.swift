//
//  ConsoleViewController.swift
//  otaviOS
//
//  Created by Otavio on 24/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class ConsoleViewController: UIViewController {

    @IBOutlet weak var consoleView: UIView!
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var runTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.runTextField.delegate = self
        self.runTextField.becomeFirstResponder()
        
        self.showConsoleHeaderAndCommand(command: "")
    }

    @IBAction func onClose(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .start)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onRun(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        AudioManager.shared.play(soundEffect: .start)
        
        let command = cleanString(self.runTextField.text!)
        self.runTextField.text = ""
        self.commandManager(command: command)
    }
    
    private func cleanString(_ s: String) -> String {
        return s.lowercased().components(separatedBy: .whitespacesAndNewlines).filter({!$0.isEmpty}).joined(separator: " ")
    }
    
    public func commandManager(command: String) {
        if Model.instance.consoleKeys[command] != nil {
            self.guestCommandRunner(command: command)
        } else if Model.instance.consoleRootKeys[command] != nil {
            if Model.instance.hasRootAccess {
                self.rootCommandRunner(command: command)
            } else {
                self.showConsoleRootRequiredError(command: command)
            }
        } else {
            self.showConsoleInvalidCommandError(command: command)
        }
    }
    
    private func guestCommandRunner(command: String) {
        switch command {
            
        case "exit":
            self.showConsoleCommandResult(isRootCommand: false, command: command)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                self.dismiss(animated: false, completion: nil)
                Timer.invalidate()
            }
            
        case "clear":
            self.showConsoleHeaderAndCommand(command: "")
            
        case "root -p sacola":
            Model.instance.hasRootAccess = true
            self.showConsoleCommandResult(isRootCommand: false, command: command)
            
        case "root -guest":
            Model.instance.hasRootAccess = false
            self.showConsoleCommandResult(isRootCommand: false, command: command)
            
        default:
            self.showConsoleCommandResult(isRootCommand: false, command: command)
        }
    }
    
    private func rootCommandRunner(command: String) {
        switch command {
            
        case "ie-provide-access --root":
            Model.instance.hasInternetExplorerAccess = true
            self.showConsoleCommandResult(isRootCommand: true, command: command)
            
        case "ie-provide-access --guest":
            Model.instance.hasInternetExplorerAccess = false
            self.showConsoleCommandResult(isRootCommand: true, command: command)
            
        default:
            self.showConsoleCommandResult(isRootCommand: true, command: command)
        }
    }
    
    private func showConsoleHeaderAndCommand(command: String) {
        self.consoleTextView.text = Model.instance.getConsoleHeader() + command + "\n\n"
    }
    
    private func showConsoleCommandResult(isRootCommand: Bool, command: String) {
        self.showConsoleHeaderAndCommand(command: command)
        self.consoleTextView.text += isRootCommand ?  Model.instance.consoleRootKeys[command]! : Model.instance.consoleKeys[command]!
    }
    
    private func showConsoleInvalidCommandError(command: String) {
        self.showConsoleHeaderAndCommand(command: command)
        self.consoleTextView.text += Model.instance.consoleInvalidCommandError
    }
    
    private func showConsoleRootRequiredError(command: String) {
        self.showConsoleHeaderAndCommand(command: command)
        self.consoleTextView.text += Model.instance.consoleRootRequiredError
    }
    
}

extension ConsoleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onRun(AnyClass.self)
        return true
    }
}
