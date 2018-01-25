//
//  SCShellView.swift
//  NiseRingoX
//
//  Created by apple  on 2017/9/10.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCShellView: NSView {
    
    var baseImg:CGImage?
    var rect:CGRect?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
//    override var isFlipped: Bool {
//        return true
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.clear.set()

        super.draw(dirtyRect)
        
        if baseImg==nil {
            __NSRectFill(self.frame)
        } else {
            __NSRectFill(self.frame)
            // Drawing code here.
            drawImage(baseImg!)
        }
    }
    
    func drawImage(_ cgImage:CGImage) {
        let myContext = NSGraphicsContext.current!.cgContext
        let rect=NSMakeRect(0, 0, CGFloat(cgImage.width), CGFloat(cgImage.height))
        myContext.clear(rect)
        //NSImage(cgImage: cgImage, size: NSMakeSize(CGFloat(cgImage.width), CGFloat(cgImage.height))).draw(in: rect)
        myContext.draw(cgImage, in: rect)
    }
    
}
