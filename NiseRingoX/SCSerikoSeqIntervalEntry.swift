//
//  SCSerikoSeqIntervalEntry.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/29.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

/*
 param : [id]interal,以降を指定して下さい。
 
 例えば
 always
 runonce
 talk,[interval]
 等です。
 
 sometimes	時々（random,2）
 rarely	さらに低率（random,4）
 random,n	1秒あたり 1/n の確率
 always	永久にループ
 runonce	そのベースサーフィスに切り替わった瞬間1回だけ
 yen-e	さくらスクリプトにおいて ¥e が出現した瞬間1回だけ
 talk,n	n 文字表示されるたびに（何か喋るたびに）
 never	自動では発動しない
 bind	着せ替え。内容については別項にて解説する。
*/
class SCSerikoSeqIntervalEntry {
    enum IntervalType {
        case always,runonce,yene,talk,never,bind
        case random(Int)
        case periodic(Int)
    }
    var intervalType:IntervalType = .never
    var type:String?
    var talkInterval:Int=0 // インターバルタイプがtalkでない場合は常に0が入っています。
    //var execInterval:Int=1// random系でない場合は常に1が入っています。
    init() {
        self.type="never"
        self.intervalType = .never
    }
    
    init(type:String) {
        self.type=type
        if type == "sometimes" {
            self.intervalType = .random(2)
        }
        if type == "rarely" {
            self.intervalType = .random(4)
        }
        if type == "always" {
            self.intervalType = .always
        }
    }
    
    init(type:String,execInterval:Int) {
        self.type=type
        self.intervalType = .never
        if type == "random" {
            self.intervalType = .random(execInterval)
        }
        if type == "periodic" {
            self.intervalType = .periodic(execInterval)
        }
    }
}
