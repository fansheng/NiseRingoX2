//
//  SCSerikoSeqGroup.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/29.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

/*
 SCSerikoSeqGroup
 
 一つのIDに含まれる全てのシーケンスデータを管理します。
 つまりsurface[id]a.txtファイルの一つ一つがこのクラスに対応します。
 */
class SCSerikoSeqGroup {
    
    var seqGroupId=0
    var sequences:[SCSerikoSequence]?
    //Vector sequences; // 中身はSCSerikoSequence
}
