//
//  SCShellWindow.swift
//  NiseRingoX
//
//  Created by apple  on 2017/9/10.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCShellWindow: NSWindow {
    var initialLocation:NSPoint?
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: NSWindow.StyleMask.borderless, backing: NSWindow.BackingStoreType.buffered, defer: false)
        //self.backgroundColor=NSColor.clear
        self.alphaValue=1.0
        self.isOpaque=false
        //self.hasShadow=false
    }
    
    override var canBecomeKey: Bool {
        return true
    }

    override func mouseDown(with event: NSEvent) {
        self.initialLocation=event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        let screenVisibleFrame=NSScreen.main?.visibleFrame
        let windowFrame=self.frame
        var newOrigin=windowFrame.origin
        let currentLocation=event.locationInWindow
        newOrigin.x += (currentLocation.x - self.initialLocation!.x)
        newOrigin.y += (currentLocation.y - self.initialLocation!.y)
        if (newOrigin.y + windowFrame.size.height) > ((screenVisibleFrame?.origin.y)! + (screenVisibleFrame?.size.height)!) {
            newOrigin.y = (screenVisibleFrame?.origin.y)! + ((screenVisibleFrame?.size.height)! - windowFrame.size.height);
        }
        
        self.setFrameOrigin(newOrigin)
    }
}
