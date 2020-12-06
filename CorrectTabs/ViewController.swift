//
//  ViewController.swift
//  CorrectTabs
//
//  Created by Alex Perathoner on 06/12/2020.
//

import Cocoa
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

let appName = "CorrectTabs"
let extensionBundleIdentifier = "AlexP.CorrectTabs-Extension"

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
	@IBAction func openGithub(_ sender: Any) {
		let url = URL(string: "https://github.com/AlexPerathoner")!
		if NSWorkspace.shared.open(url) {
			print("default browser was successfully opened")

		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = appName
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                if (state.isEnabled) {
                    self.appNameLabel.stringValue = "\(appName)'s extension is currently on."
                } else {
                    self.appNameLabel.stringValue = "\(appName)'s extension is currently off. You can turn it on in Safari Extensions preferences."
                }
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            guard error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
