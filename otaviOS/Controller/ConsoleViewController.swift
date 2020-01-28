//
//  ConsoleViewController.swift
//  otaviOS
//
//  Created by Otavio on 24/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class ConsoleViewController: BaseViewController {

    @IBOutlet weak var consoleView: UIView!
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var runTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    
    @IBOutlet weak var suggestionView: UIView!
    @IBOutlet weak var suggestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.runTextField.delegate = self
        self.runTextField.becomeFirstResponder()
        self.runTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.suggestionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.suggestionButton.setTitleColor(.white, for: .normal)
        
        self.showConsoleHeaderAndCommand(command: "")
        self.applyConsoleAppearance()
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
        self.suggestionButton.titleLabel?.text = "help"
        self.commandManager(command: command)
    }
    
    @IBAction func onSuggestion(_ sender: UIButton) {
        self.runTextField.text = sender.titleLabel?.text ?? ""
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
            
        case "sudo su -p sacola":
            Model.instance.hasRootAccess = true
            self.showConsoleCommandResult(isRootCommand: false, command: command)
            
        case "color -white":
            Model.instance.consoleFontColor = .white
            self.applyConsoleAppearance()
            self.showConsoleHeaderAndCommand(command: "")
            
        case "color -green":
            Model.instance.consoleFontColor = .green
            self.applyConsoleAppearance()
            self.showConsoleHeaderAndCommand(command: "")
            
        case "color -blue":
            Model.instance.consoleFontColor = .blue
            self.applyConsoleAppearance()
            self.showConsoleHeaderAndCommand(command: "")
            
        case "color -red":
            Model.instance.consoleFontColor = .red
            self.applyConsoleAppearance()
            self.showConsoleHeaderAndCommand(command: "")

        default:
            self.showConsoleCommandResult(isRootCommand: false, command: command)
        }
    }
    
    private func rootCommandRunner(command: String) {
        switch command {
            
        case "ie access -allow":
            Model.instance.hasInternetExplorerAccess = true
            self.showConsoleCommandResult(isRootCommand: true, command: command)
            
        case "ie access -deny":
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
    
    private func applyConsoleAppearance() {
        self.consoleTextView.textColor = Model.instance.consoleFontColor
        self.runTextField.textColor = Model.instance.consoleFontColor
    }
    
}

extension ConsoleViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onRun(AnyClass.self)
        return true
    }
    
    @objc func textFieldDidChange() {
        self.suggestionButton.setTitle("help", for: .normal)
        
        for item in Model.instance.consoleKeys {
            if item.key == "sudo su -p sacola" { continue }
            if item.key == runTextField.text! {
                self.suggestionButton.setTitle(item.key, for: .normal)
                return
            }
        }
        
        for item in Model.instance.consoleKeys {
            if item.key == "sudo su -p sacola" { continue }
            if item.key.contains(runTextField.text!) {
                self.suggestionButton.setTitle(item.key, for: .normal)
                return
            }
        }
        
        for item in Model.instance.consoleRootKeys {
            if item.key == runTextField.text! {
                self.suggestionButton.setTitle(item.key, for: .normal)
                return
            }
        }
        
        for item in Model.instance.consoleRootKeys {
            if item.key.contains(runTextField.text!) {
                self.suggestionButton.setTitle(item.key, for: .normal)
                return
            }
        }
    }
}
