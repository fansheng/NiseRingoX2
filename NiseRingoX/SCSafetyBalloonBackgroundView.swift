//
//  SCSafetyBalloonBackgroundView.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/23.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCSafetyBalloonBackgroundView: NSView {
    var bgimage:CGImage?
    var rect:CGRect
    /*NSImage bgimage;
     NSFont sstpMessageFont;
     NSColor sstpMessageColor;
     NSMutableAttributedString sstpmessage = null;
     NSPoint sstpMessageLoc;
     NSImage sstpMarkerImage;
     NSPoint sstpMarkerLoc;
     
 */
    let textStorage: NSTextStorage = NSTextStorage(string: "Here's to the crazy ones, the misfits, the rebels, the troublemakers, the round pegs in the square holes, the ones who see things differently.")
    let layoutManager: NSLayoutManager = NSLayoutManager()
    let textContainer: NSTextContainer = NSTextContainer()
    
    override init(frame frameRect: NSRect) {
        self.rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        let image = NSImage(contentsOfFile: "/Users/apple/.ninix/balloon/blackcross2/balloons2.png")!
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        self.rect = CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        self.bgimage=cgImage
        super.init(coder: coder)
        self.textContainer.size=NSSize(width: cgImage.width, height: cgImage.height)
        self.layoutManager.addTextContainer(self.textContainer)
        self.textStorage.addLayoutManager(self.layoutManager)
        self.window?.setFrame(self.rect , display:true)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func convertImage(_ cgimage: CGImage) -> CGImage {
        let pixelData = cgimage.dataProvider!.data
        let pdata = CFDataGetBytePtr(pixelData)!
        let r = CGFloat(pdata.pointee)
        let g = CGFloat(pdata[1])
        let b = CGFloat(pdata[2])
        return cgimage.copy(maskingColorComponents: [r,r,g,g,b,b])!
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        
        let glyphRange = self.layoutManager.glyphRange(for: self.textContainer)
        let usedRect = self.layoutManager.usedRect(for: self.textContainer)
        
        super.draw(dirtyRect)
        NSColor.clear.set()
        __NSRectFill(self.frame)
        // Drawing code here.
        let myContext = NSGraphicsContext.current!.cgContext
        let resultimage = convertImage(bgimage!)
        myContext.draw(resultimage, in: rect)
        
        let s=textStorage
        s.beginEditing()
        s.addAttribute(NSAttributedStringKey.link, value: "w", range: NSMakeRange(1, 3))
        s.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.blue, range: NSMakeRange(1, 3))
        s.addAttribute(NSAttributedStringKey.underlineStyle, value: NSNumber(integerLiteral: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(1, 3))
        s.endEditing()
        
        s.draw(at: NSPoint(x: 10, y: 10))
        //myContext.NSAttributedStringKey
        
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: NSPoint(x: 0, y: 100))
        // Drawing code here.
    }
    override var intrinsicContentSize: NSSize {
        return NSSize(width: rect.width, height: rect.height)
    }
    
}
