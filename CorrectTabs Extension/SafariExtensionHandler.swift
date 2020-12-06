//
//  SafariExtensionHandler.swift
//  CorrectTabs Extension
//
//  Created by Alex Perathoner on 06/12/2020.
//

import SafariServices
import HotKey
import Carbon

class SafariExtensionHandler: SFSafariExtensionHandler {
	
	public var hotKeyOne: HotKey? {
		didSet {
			guard let hotKey = hotKeyOne else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 0)
			}
		}
	}
	public var hotKeyTwo: HotKey? {
		didSet {
			guard let hotKey = hotKeyTwo else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 1)
			}
		}
	}
	public var hotKeyThree: HotKey? {
		didSet {
			guard let hotKey = hotKeyThree else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 2)
			}
		}
	}
	public var hotKeyFour: HotKey? {
		didSet {
			guard let hotKey = hotKeyFour else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 3)
			}
		}
	}
	public var hotKeyFive: HotKey? {
		didSet {
			guard let hotKey = hotKeyFive else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 4)
			}
		}
	}
	public var hotKeySix: HotKey? {
		didSet {
			guard let hotKey = hotKeySix else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 5)
			}
		}
	}
	public var hotKeySeven: HotKey? {
		didSet {
			guard let hotKey = hotKeySeven else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 6)
			}
		}
	}
	public var hotKeyEight: HotKey? {
		didSet {
			guard let hotKey = hotKeyEight else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 7)
			}
		}
	}
	public var hotKeyNine: HotKey? {
		didSet {
			guard let hotKey = hotKeyNine else {
				return
			}
			hotKey.keyDownHandler = {
				self.activateCorrectTab(index: 8)
			}
		}
	}
	
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
		if(hotKeyOne == nil) {
			hotKeyOne = HotKey(keyCombo: KeyCombo(key: .one, modifiers: .command))
		}
		if(hotKeyTwo == nil) {
			hotKeyTwo = HotKey(keyCombo: KeyCombo(key: .two, modifiers: .command))
		}
		if(hotKeyThree == nil) {
			hotKeyThree = HotKey(keyCombo: KeyCombo(key: .three, modifiers: .command))
		}
		if(hotKeyFour == nil) {
			hotKeyFour = HotKey(keyCombo: KeyCombo(key: .four, modifiers: .command))
		}
		if(hotKeyFive == nil) {
			hotKeyFive = HotKey(keyCombo: KeyCombo(key: .five, modifiers: .command))
		}
		if(hotKeySix == nil) {
			hotKeySix = HotKey(keyCombo: KeyCombo(key: .six, modifiers: .command))
		}
		if(hotKeySeven == nil) {
			hotKeySeven = HotKey(keyCombo: KeyCombo(key: .seven, modifiers: .command))
		}
		if(hotKeyEight == nil) {
			hotKeyEight = HotKey(keyCombo: KeyCombo(key: .eight, modifiers: .command))
		}
		if(hotKeyNine == nil) {
			hotKeyNine = HotKey(keyCombo: KeyCombo(key: .nine, modifiers: .command))
		}
    }
	
	func getNonPinnedTabs(completion: @escaping ([SFSafariTab]) -> ()) {
		SFSafariApplication.getActiveWindow { window in // get safari window
			window?.getAllTabs(completionHandler: { tabs in // as the method to get the active windows is on another dispatchqueue we need to invoke it in this way
				
				var realTabs: [SFSafariTab] = []
				for tab in tabs {
					tab.getContainingWindow { containerWindow in // checking if tab is pinned: https://stackoverflow.com/questions/63509871/check-if-tab-page-is-pinned-in-safari-app-extension
						if containerWindow != nil {
							// Tab is not pinned
							DispatchQueue.main.async {
								realTabs.append(tab)
								if(tabs.firstIndex(of: tab)! + 1 == tabs.count) {
									completion(realTabs)
								}
							}
						}
					}
				}
			})
		}
	}
	
	func activateCorrectTab(index: Int) {
		getNonPinnedTabs { (nonPinnedTabs) in
			nonPinnedTabs[index].activate {
				NSLog("Activated ", index)
			}
		}
	}
	
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
		print("Toolbar item was clicked!")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
