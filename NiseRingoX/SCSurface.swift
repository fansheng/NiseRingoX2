//
//  SCSurface.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/29.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation
/*
 一枚のサーフィスを表すクラスです。
 サーフィスはpngデータ、〜s.txt、〜a.datファイルを持ちます。
 */
class SCSurface {
    /*
     NSImage rawImage; // ここがnullの時は圧縮されたNSImageがcompressedImageに入っている。
     NSData compressedImage;
     NSSize originalSize;
     int id;
     Vector collisions; // 中身はSCSurfaceCollision。
     double ratio;
     Map defs;
     */
    var baseImage:CGImage
    var surfaceID:Int=0
    var animation:[Int:SCSerikoSequence]=[:]
    var collision:[Int]=[]
    
    init(surfaceID:Int,baseImage:CGImage) {
        self.surfaceID=surfaceID
        self.baseImage=baseImage
    }
}
