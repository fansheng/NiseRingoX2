//
//  SCBalloonTextView.swift
//  NiseRingoX
//
//  Created by apple  on 2018/1/28.
//  Copyright © 2018年 test. All rights reserved.
//

import Cocoa

class SCBalloonTextView: NSTextView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor=NSColor.clear
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
