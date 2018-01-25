//
//  SCBorderlessWindow.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/23.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCBorderlessWindow: NSWindow {
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

}
