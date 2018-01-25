//
//  SCSerikoSequenceRunner.swift
//  NiseRingoX
//
//  Created by apple  on 2017/9/20.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

/*
 ランナーは独立したスレッドです。
 
 次のタイプは常時起動しています。シーケンス終了後、次の発動タイミングまでスリープします。
 random (sometimes,rarely)
 always
 talk
 yen-e
 
 次のタイプは必要な時に起動され、シーケンス終了後にスレッドが停止します。
 runonce
 never
 
 talk,yen-eは常時起動していますが、実際に動き出すタイミングは不定です。
 なので、発動タイミングは外部から通知してもらう必要があります。
 
 常時起動タイプは、厳密にはスリープしてから発動、スリープしてから発動、という動作を行います。
 これはシーケンスグループが切り替わった際にrunonceとsometimesとrarelyとalwaysが一度に全て動きだすのを防ぐためです。
 */
class SCSerikoSequenceRunner: Thread {
    /*    SCShell shell;
     SCSeriko seriko;
     SCSerikoSequence seq;
     SCShellWindowController target;
     SCSession session;
     boolean end_and_quit; // trueならシーケンス終了後にランナーが停止します。runonce等で使われます。
     int exec_probability = 1; // 発動前の待ち時間（秒毎の発動確率）です。
     // random(rarely等のマクロ含む）の場合のみ意味を持ちます。そうでなければ1になります。
     SCShellLayer layer; // overlay用レイヤーです。シーケンス内で初めてoverlayが出てきた時に作成されます。
     int scope;
     
     private volatile boolean signal_stop = false;
 */
    override func main() {
        
    }
}
