//
//  SCSerikoSequence.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/29.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

/*
 SCSerikoSequence
 
 シーケンス一つを表します。
 例えば次のようなものです。
 
 0interval,sometimes
 0pattern0,100,5,overlay,0,0
 0pattern1,101,5,overlay,0,0
 0pattern2,100,5,overlay,0,0
 0pattern3,-1,5,overlay,0,0
 */
class SCSerikoSequence {
    var timer:Timer?
    var interval:SCSerikoSeqIntervalEntry?// intervalエントリの中身。
    var option:SCSerikoSeqOptionEntry?// optionエントリの中身。省略されていたらnull。
    var patterns:[SCSerikoSeqPatternEntry]?// patternエントリの中身。中身はSCSerikoSeqPatternEntryまたはnull。パターンのIDと配列のIDは完全に一致します。
    init(_ patterns:[SCSerikoSeqPatternEntry]) {
        self.patterns=patterns
        self.interval=SCSerikoSeqIntervalEntry()
    }
    init(interval:SCSerikoSeqIntervalEntry,patterns:[SCSerikoSeqPatternEntry]) {
        self.patterns=patterns
        self.interval=interval
    }
    init(interval:SCSerikoSeqIntervalEntry) {
        self.interval=interval
        self.patterns=[]
    }

}
