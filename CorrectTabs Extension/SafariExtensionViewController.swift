//
//  SafariExtensionViewController.swift
//  CorrectTabs Extension
//
//  Created by Alex Perathoner on 06/12/2020.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
