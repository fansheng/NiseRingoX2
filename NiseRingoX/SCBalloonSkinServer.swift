//
//  SCBalloonSkinServer.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/16.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation
class SCBalloonSkinServer {
    var balloonsImages:[CGImage] = []
    var balloonkImages:[CGImage] = []
    var arrow0Image:CGImage?
    var arrow1Image:CGImage?
    var name:String?

    init(_ path:String) {
        let desc = SCDescription(path+"descript.txt")
        self.name = desc.getStrValue("name")
        
        let fm=FileManager.init()
        let sstpmarkerfile=path+"sstp.png"
        let arrow0file=path+"arrow0.png"
        let arrow1file=path+"arrow1.png"
        if fm.fileExists(atPath: sstpmarkerfile) {
            //
        }
        if fm.fileExists(atPath: arrow0file) {
            //var arrow0Image=NSImage
        }
        
        if fm.fileExists(atPath: arrow1file) {
            
        }

    }
    
    /*-(id)initWithPath:(NSString *)dir_path{
     self = [super init];
     if (self) {
     // 存在しないパスを示すバルーンスキンサーバを作ろうとした場合、空のサーバーが生成されます。
     path=dir_path;
     NSString *dir=[[[SCFoundation sharedFoundation] getParentDirOfBundle] stringByAppendingPathComponent:path];
     
     desc=[[SCDescription alloc] initWithFilename:[dir stringByAppendingPathComponent:@"descript.txt"]];
     name=[desc getStrValue:@"name"];
     
     NSString *sstpmarkerfile = [dir stringByAppendingPathComponent:@"sstp.png"];
     NSString *arrow0file = [dir stringByAppendingPathComponent:@"arrow0.png"];
     NSString *arrow1file = [dir stringByAppendingPathComponent:@"arrow1.png"];
     
     NSFileManager *sharedFM = [NSFileManager defaultManager];
     if ([sharedFM fileExistsAtPath:sstpmarkerfile]){
     sstpMarker=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:sstpmarkerfile]];
     }
     if ([sharedFM fileExistsAtPath:arrow0file]){
     arrow_up=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:arrow0file]];
     }
     if ([sharedFM fileExistsAtPath:arrow1file]){
     arrow_down=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:arrow1file]];
     }
     }
     return self;
     }*/
}
