//
//  SCShellWindowController.swift
//  NiseRingoX
//
//  Created by apple  on 2017/9/10.
//  Copyright © 2017年 test. All rights reserved.
//

import Cocoa

class SCShellWindowController: NSWindowController {
    let shellPath="/Users/apple/.ninix/ghost/Taromati2_Chinese/shell/test/"
    @IBOutlet var view: SCShellView!
    var surfaces:[Int:SCSurface]=[:]
    
    var baseImg:CGImage?
    var currentSurfaceID:Int=0
    var currentAnimation:[Int:SCSerikoSeqPatternEntry]=[:]
    var queue:OperationQueue=OperationQueue()
    var currentimg:CGImage?

    override var windowNibName: NSNib.Name? {
        return NSNib.Name("ShellWindow")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    init(_ scope:Int32) {
        super.init(window: nil)
        self.loadSurfaceImage()
        self.loadDescript()
    }
    
    func loadSurfaceImage() {
        let fileManager=FileManager.default
        let fileEnumerator = fileManager.enumerator(atPath: shellPath)
        for file in fileEnumerator! {
            let filename="\(file)"
            let reg=try? NSRegularExpression(pattern: "^surface(\\d+)\\.png$", options: NSRegularExpression.Options.anchorsMatchLines)
            
            let match=reg!.firstMatch(in: filename, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0,filename.count))
            if let ms = match {
                if ms.numberOfRanges>1 {
                    let range = ms.range(at: 1)
                    let imgID=Int(getSubString(filename,by: range))!
                    let cgimg = self.addMaskImage(shellPath+filename)
                    surfaces[imgID] = SCSurface(surfaceID: imgID, baseImage: cgimg!)
                }
            }
        }
    }
    
    func getSubString(_ s:String,by range:NSRange)->String {
        let start=s.index(s.startIndex, offsetBy: range.location)
        let end=s.index(s.startIndex, offsetBy: (range.location+range.length))
        return String(s[start..<end])
    }
    
    func addMaskImage(_ imagePath:String) -> CGImage?{
        let image = NSImage(contentsOfFile: imagePath)!
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        
        let maskPath=imagePath.replacingOccurrences(of: ".png", with: ".pna")
        if imagePath.hasSuffix(".png") && FileManager.default.fileExists(atPath: maskPath) {
            let imagemask = NSImage(contentsOfFile: maskPath)!
            let cgimagemask = imagemask.cgImage(forProposedRect: nil, context: nil, hints: nil)!
            return cgImage.masking(createImageMask(cgimagemask))
        }
        else {
            return maskImage(cgImage)
        }
    }
    
    func maskImage(_ cgimage: CGImage) -> CGImage? {
        let pixelData = cgimage.dataProvider!.data
        let pdata = CFDataGetBytePtr(pixelData)!
        let r = CGFloat(pdata.pointee)
        let g = CGFloat(pdata[1])
        let b = CGFloat(pdata[2])
        return cgimage.copy(maskingColorComponents: [r,r,g,g,b,b])
    }
    
    func createImageMask(_ cgimage: CGImage) -> CGImage {
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(cgimage.width), height: Int(cgimage.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(cgimage, in: CGRect(x: 0, y: 0, width: cgimage.width, height: cgimage.height))
        
        // Get an image of the context
        let maskImageRef = context?.makeImage()
        return maskImageRef!
    }
    
    func makeSurfaceSeriko(_ imgID:Int,_ serikoSeq:[String]) {
        var seriko:[Int:SCSerikoSequence]=[:]
        var animationID=0
        var patternID=0
        var surfaceID=0
        var interval=0
        var methodType=""
        var left=0
        var top=0
        let regElement=try? NSRegularExpression(pattern: "^element(\\d+),(base|overlay|overlayfast|replace|interpolate|asis|move|bind|add|reduce|insert),(\\w+.png),(\\d+),(\\d+)$", options: NSRegularExpression.Options.anchorsMatchLines)
        let regInterval=try? NSRegularExpression(pattern: "^(\\d+)interval,(sometimes|rarely|random,\\d+|periodic,\\d+|always|runonce|never|yen-e|talk,\\d+|bind)$", options: NSRegularExpression.Options.anchorsMatchLines)
        let regPattern=try? NSRegularExpression(pattern: "^(\\d+)pattern(\\d+),(\\-?\\d+),(\\d+),(base|overlay|overlayfast|replace|interpolate|asis|move|bind|add|reduce|insert,\\d+|start,\\d+|stop,\\d+),(\\d+),(\\d+)$", options: NSRegularExpression.Options.anchorsMatchLines)
        let regPattern2=try? NSRegularExpression(pattern: "^(\\d+)pattern(\\d+),(\\-?\\d+),(\\d+),(alternativestart),\\[((?:\\d+\\.)*\\d+)\\]$", options: NSRegularExpression.Options.anchorsMatchLines)
        var cgimage:CGImage?
        for s in serikoSeq {
            if let ms = regInterval!.firstMatch(in: s, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0,s.count)) {
                if ms.numberOfRanges>2 {
                    animationID = Int(getSubString(s,by: ms.range(at: 1)))!
                    seriko[animationID] = SCSerikoSequence(interval:SCSerikoSeqIntervalEntry(type: getSubString(s,by: ms.range(at: 2))))
                }
            }
            
            if let ms = regPattern!.firstMatch(in: s, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0,s.count)) {
                if ms.numberOfRanges>7 {
                    animationID = Int(getSubString(s,by: ms.range(at: 1)))!
                    patternID = Int(getSubString(s,by: ms.range(at: 2)))!
                    surfaceID = Int(getSubString(s,by: ms.range(at: 3)))!
                    interval = Int(getSubString(s,by: ms.range(at: 4)))!
                    methodType = getSubString(s,by: ms.range(at: 5))
                    left = Int(getSubString(s,by: ms.range(at: 6)))!
                    top = Int(getSubString(s,by: ms.range(at: 7)))!
                seriko[animationID]!.patterns!.append(SCSerikoSeqPatternEntry(method:methodType,surfaceid:surfaceID,interval:interval,offsetx:left,offsety:top))
                }
            }
            
            if let ms = regPattern2!.firstMatch(in: s, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0,s.count)) {
                if ms.numberOfRanges>6 {
                    animationID = Int(getSubString(s,by: ms.range(at: 1)))!
                    patternID = Int(getSubString(s,by: ms.range(at: 2)))!
                    surfaceID = Int(getSubString(s,by: ms.range(at: 3)))!
                    interval = Int(getSubString(s,by: ms.range(at: 4)))!
                    methodType = getSubString(s,by: ms.range(at: 5))
                    let aids = try getSubString(s,by: ms.range(at: 6)).split(separator: ".").map({Int($0)!})
                    seriko[animationID]!.patterns!.append(SCSerikoSeqPatternEntry(entries:aids))
                }
            }
            
            if let ms = regElement!.firstMatch(in: s, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0,s.count)) {
                if ms.numberOfRanges>5 {
                    let imagename=getSubString(s,by: ms.range(at: 3))
                    let x = Int(getSubString(s,by: ms.range(at: 4)))!
                    let y = Int(getSubString(s,by: ms.range(at: 5)))!
                    if cgimage == nil {
                        cgimage=self.addMaskImage(shellPath+imagename)
                    } else {
                        cgimage = overlayerImage(baseImage:cgimage!,overImage:self.addMaskImage(shellPath+imagename)!,left:x,top:y)
                    }
                }
            }
        }
        if cgimage != nil {
            if surfaces[imgID] != nil {
                surfaces[imgID]?.baseImage=cgimage!
            }
            else{
                surfaces[imgID] = SCSurface(surfaceID: imgID, baseImage: cgimage!)
            }
        }
        if surfaces[imgID] != nil {
            surfaces[imgID]?.animation=seriko
        }
        return
    }
    
    func loadDescript() {
        let descript=SCBlockedDescription(shellPath+"surfaces.txt")
        let surfaceDic=descript.dic
        var surfaceID=0
        for surface in surfaceDic {
            if surface.key.hasPrefix("surface") {
                surfaceID=Int(surface.key[surface.key.index(surface.key.startIndex, offsetBy: 7)..<surface.key.endIndex])!
                makeSurfaceSeriko(surfaceID,surface.value)
            }
        }
    }

    
    
    func changeSurface(_ surfaceId:Int) {
        for (_,animation) in self.surfaces[self.currentSurfaceID]!.animation {
            animation.timer?.invalidate()
        }
        queue.cancelAllOperations()
        currentAnimation.removeAll()
        self.currentSurfaceID=surfaceId
        baseImg = surfaces[surfaceId]?.baseImage
        //animation=surfaces[surfaceId]!.animation
        if baseImg != nil {
            let newrect = NSMakeRect(0, 0, CGFloat(baseImg!.width), CGFloat(baseImg!.height))
            //let newsize = NSMakeSize(CGFloat(baseImg!.width), CGFloat(baseImg!.height))
            //view.setFrameSize(newsize)
            window?.setFrame(newrect, display:false)
            view.baseImg = baseImg
            window?.display()
        }
        startAnimation()
    }
    
    
    func start(_ animationID:Int) {
        queue.addOperation {
            //print("开始执行异步任务")
            if self.currentAnimation[animationID] != nil {
                self.currentAnimation[animationID]=nil
            }
            let patterns=self.surfaces[self.currentSurfaceID]!.animation[animationID]!.patterns!
            for (_,pattern) in patterns.enumerated() {
                if pattern.method=="alternativestart" {
                    let entries=pattern.entries!
                    self.start(entries[Int(arc4random() % UInt32(entries.count))])
                }
                else {
                    Thread.sleep(forTimeInterval: TimeInterval(Double(pattern.interval!)/100))
                    self.currentAnimation[animationID]=pattern
                    self.mergeImage()
                }
            }
            let interval=self.surfaces[self.currentSurfaceID]!.animation[animationID]!.interval!
            switch interval.intervalType  {
            case .always:
                self.start(animationID)
            default:
                break
            }
            
        }
    }
    
    func mergeImage(){
        var baseImg=self.baseImg
        for (_,pattern) in self.currentAnimation {
            let overImage=self.surfaces[pattern.surfaceid]?.baseImage
            let offsetx=pattern.offsetx!
            let offsety=pattern.offsety!
            
            if pattern.methodType == .base {
                baseImg=overImage
            }
            else if pattern.methodType == .move {
                self.moveImage(left: offsetx,top: offsety)
            }
            else {
                if pattern.surfaceid>=0 {
                    baseImg=self.overlayerImage(baseImage: baseImg!,overImage: overImage!,left: offsetx,top: offsety)
                }
            }
        }
        self.view.baseImg=baseImg
        OperationQueue.main.addOperation {
            //print("回到住线程刷新UI")
            self.view.display()
        }
    }
    
    /*
     animation*.interval
     eg:
     sometimes  1/2 per sec
     rarely     1/4 per sec
     random,n   1/n per sec
     periodic,n n sec
     always     loop
     runonce    surface change
     never      start call
     yen-e      \e
     talk,n     n chars show
     bind
     */
    func startAnimation() {
        for (animationID,animation) in self.surfaces[self.currentSurfaceID]!.animation {
            let interval=animation.interval!
            switch interval.intervalType {
            case .runonce,.always:
                self.start(animationID)
            case .random(let execInterval):
                animation.timer=Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { (t) in
                    if arc4random() % UInt32(execInterval)==0 {
                        self.start(animationID)
                    }
                })
            case .periodic(let execInterval):
                animation.timer=Timer.scheduledTimer(withTimeInterval: TimeInterval(execInterval), repeats: true, block: { (t) in
                    self.start(animationID)
                })
            default: break
                // self.start(animationID)
            }
            
        }
    }
    
    func overlayerImage(baseImage:CGImage,overImage:CGImage,left:Int,top:Int) -> CGImage? {
        let width = baseImage.width
        let height = baseImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let offscreenContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        let rect: CGRect = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
        offscreenContext?.clear(rect)
        offscreenContext?.draw(baseImage, in: rect)
        drawPatternImage(offscreenContext!,overImage,CGFloat(left),CGFloat(height)-CGFloat(top))
        return offscreenContext?.makeImage()
    }
    
    func moveImage(left:Int,top:Int) {
        let rect=self.window?.frame.offsetBy(dx: CGFloat(left), dy: -CGFloat(top))
        self.window?.setFrame(rect!, display: false)
    }
    
    
    func drawPatternImage(_ context:CGContext, _ cgImage:CGImage,_ left:CGFloat,_ top:CGFloat) {
        let rect=NSMakeRect(CGFloat(left), CGFloat(top)-CGFloat(cgImage.height), CGFloat(cgImage.width), CGFloat(cgImage.height))
        context.draw(cgImage, in: rect)
    }
    

}
