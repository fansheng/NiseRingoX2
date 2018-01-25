//
//  AppDelegate.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/13.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var SurfaceMenu: NSMenuItem!
    @IBOutlet weak var AnimationMenu: NSMenuItem!
    //var descript:SCBlockedDescription?
    var mainController2:SCSafetyBalloonController?
    var mainController:SCShellWindowController?
    @IBAction func testBalloon(_ sender: Any) {
        
        let mainController=SCSafetyBalloonController(windowNibName: NSNib.Name(rawValue: "SafetyBalloon"))
        mainController.showWindow(self)
        self.mainController2=mainController
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //descript=SCBlockedDescription("/Users/apple/.ninix/ghost/Taromati2_Chinese/shell/master/surfaces.txt")
        //_=SCDescription("/Users/apple/Desktop/XCodeTest/nanika/test/descript2.txt")
        
        let mainController=SCShellWindowController(0)
        mainController.showWindow(self)
        self.mainController=mainController
        for (surfaceID,surface) in mainController.surfaces {
            var title=String(surfaceID)
            if surface.animation.count==0 {
                title=title+"*"
            }
            let menu=NSMenuItem(title: title, action:  #selector(testChangeSurface), keyEquivalent: "")
            menu.tag=surfaceID
            SurfaceMenu.submenu?.addItem(menu)
        }
    }
    
    @objc func testChangeSurface(_ sender: NSMenuItem) {
        let surfaceID=sender.tag
        self.mainController!.changeSurface(surfaceID)
        let surface=self.mainController!.surfaces[surfaceID]
        AnimationMenu.submenu?.removeAllItems()
        for (animationID,_) in surface!.animation {
            let submenu=NSMenuItem(title: String(animationID), action: #selector(testChangeSeriko), keyEquivalent: "")
            submenu.tag=animationID
            AnimationMenu.submenu?.addItem(submenu)
        }
        
    }
    
    @objc func testChangeSeriko(_ sender: NSMenuItem) {
        self.mainController!.start(sender.tag)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}

