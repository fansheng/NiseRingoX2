//
//  SCSerikoSeqPatternEntry.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/29.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

/*
 SCSerikoSeqPatternEntry
 
 一つのpatternエントリのデータを表します。
 */
/*
 datalineには、[seqid]pattern[index],の後のデータを指定して下さい。
 
 例えば、
 1pattern0,50,20,overlay,10,0
 だったら
 50,20,overlay,10,0
 です。
	*/
class SCSerikoSeqPatternEntry {
    enum MethodType {
        case base,overlay,overlayfast,replace,interpolate,asis,move,bind,add,reduce
        case insert,start,stop
        case alternativestart,alternativestop
    }
    
    // 基本パラメータ
    var surfaceid:Int=0
    var interval:Int?// 単位は常にミリ秒
    var method:String?
    var methodType:MethodType
    var offsetx:Int?
    var offsety:Int?
    
    // start用
    var seq_id:Int?
    
    // alternativestart用
    var entries:[Int]?
    
    // insert用
    var bind_id:Int?
    
    init(surfaceid:Int,interval:Int,offsetx:Int,offsety:Int) {
        self.surfaceid=surfaceid
        self.interval=interval
        self.offsetx=offsetx
        self.offsety=offsety
        self.method="overlay"
        self.methodType = .overlay
    }
    
    init(method:String,surfaceid:Int,interval:Int,offsetx:Int,offsety:Int) {
        self.surfaceid=surfaceid
        self.interval=interval
        self.offsetx=offsetx
        self.offsety=offsety
        self.method=method
        switch method {
        case "base":
            self.methodType = .base
        case "overlay":
            self.methodType = .overlay
        case "overlayfast":
            self.methodType = .overlayfast
        case "replace":
            self.methodType = .replace
        case "interpolate":
            self.methodType = .interpolate
        case "asis":
            self.methodType = .asis
        case "move":
            self.methodType = .move
        case "add":
            self.methodType = .add
        case "reduce":
            self.methodType = .reduce
        default:
            self.methodType = .overlay
        }
    }
    init(entries:[Int]) {
        self.method="alternativestart"
        self.entries=entries
        self.methodType = .alternativestart
    }

}
