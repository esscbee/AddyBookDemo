//
//  GameViewController.swift
//  AddyBookDemo
//
//  Created by Stephen Brennan on 8/1/16.
//  Copyright (c) 2016 Stephen Brennan. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import Contacts



class GameViewController: UIViewController, AddressBook {
    var results: [CNContact]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressBook()
        resetScene()
        
     }
    func getFullNames() -> [String]? {
        if let results = self.results {
            var ret = [String]()
            for c in results {
                if let fn = CNContactFormatter.stringFromContact(c, style: .FullName) {
                    ret.append(fn)
                }
            }
            if ret.count > 0 {
                return ret
            }
        }
        return nil
    }
    func loadAddressBook() {
        let t = CNContactStore.authorizationStatusForEntityType(.Contacts)
        switch(t) {
        case .Authorized, .NotDetermined:
            break
        case .Denied, .Restricted:
            return 
        }
        
        do {
            let contactStore = CNContactStore()
            let keysToFetch = [
                CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
                ]
            let allContainers = try contactStore.containersMatchingPredicate(nil)
            var results = [CNContact]()
            for container in allContainers {
                let fp = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
                do {
                    let containerResults = try contactStore.unifiedContactsMatchingPredicate(fp, keysToFetch: keysToFetch)
                    results.appendContentsOf(containerResults)
                } catch {
                    print("Error fetching results for container")
                }
            }
            if results.count > 0 {
                self.results = results
            }
        } catch {
            print("Error")
        }
    }
    
    func resetScene() {
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .ResizeFill
            scene.setAddy(self)
            
            skView.presentScene(scene)
        }
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            resetScene()
        }
    }


    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
