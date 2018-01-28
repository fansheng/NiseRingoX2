//
//  SCSafetyBalloonController.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/23.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCSafetyBalloonController: NSWindowController,NSTextViewDelegate {

    @IBOutlet var balloontextview: SCBalloonTextView!
    override func windowDidLoad() {
        super.windowDidLoad()
        balloontextview.delegate=self
        balloontextview.backgroundColor=NSColor.clear
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        //balloontextview.textContainer?.containerSize
        
        appendChoiceText(title:"タイトル",tag:"ID")
        /*let img=NSImage(contentsOfFile: "/Users/apple/.ninix/balloon/blackcross2/balloonc3.png")
        //let attachmentCell = NSTextAttachmentCell(imageCell: img)
        let rect=NSMakeRect(10, 10, 100, 100)
        //attachmentCell.draw(withFrame: rect, in: textview, characterIndex: 2)
        //img?.draw(in: rect)
        let attachment = NSTextAttachment()
        attachment.image = img
        attachment.bounds=rect
        let attributedStr = NSAttributedString(attachment: attachment)
        balloontextview.textStorage?.append(attributedStr)*/
    }
    //\q[タイトル,ID]
    func appendChoiceText(title:String,tag:String) {
        let text:NSAttributedString=NSAttributedString(string: title, attributes: [NSAttributedStringKey.link:tag])
        balloontextview.textStorage?.append(text)
    }
    
    //\f[color,色指定]
    func appendForegroundColor(text:String,color:NSColor) {
        let attText:NSAttributedString=NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:color])
        balloontextview.textStorage?.append(attText)
    }
    
    func textView(_ textView: NSTextView, clickedOnLink link: Any, at charIndex: Int) -> Bool {
        print(link)
        return true
    }

}
