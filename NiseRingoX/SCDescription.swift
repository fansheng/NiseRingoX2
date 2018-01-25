//
//  SCDescription.swift
//  NiseRingoX
//
//  Created by apple  on 2017/8/13.
//  Copyright © 2017年 test. All rights reserved.
//

import Foundation

class SCDescription {
    var dic = [String: String]()
    var filename: String
    
    init(_ filename:String) {
        self.filename=filename
        load(filename)
    }
    
    func load(_ filename: String) {
        var stringFromFile = ""
        var encoding:String.Encoding=String.Encoding.utf8
        do {
            stringFromFile = try String(contentsOfFile: filename, usedEncoding: &encoding)
        } catch {
            do {
                stringFromFile = try String(contentsOfFile: filename, encoding: String.Encoding.ascii)
            } catch {
                
            }
        }
        var charsetString = "shift_jis"
        var arrayString = stringFromFile.components(separatedBy: CharacterSet.newlines)
        for s in arrayString {
            if s.hasPrefix("charset,") {
                charsetString=s[s.index(s.startIndex, offsetBy: 8)...].trimmingCharacters(in: CharacterSet.whitespaces).lowercased()
                break
            }
        }
        if charsetString == "utf8" || charsetString == "utf-8" || charsetString == "utf_8" {
            encoding=String.Encoding.utf8
        }
        else if charsetString == "shift_jis" || charsetString == "shift-jis" {
            encoding=String.Encoding.shiftJIS
        }
        else if charsetString == "gb2312" || charsetString == "gbk" {
            encoding=String.Encoding.ascii
        }
        
        do {
            stringFromFile = try String(contentsOfFile: filename, encoding: encoding)
        } catch {
            
        }
        arrayString = stringFromFile.components(separatedBy: CharacterSet.newlines)
        for s in arrayString {
            let lineString = s.trimmingCharacters(in: CharacterSet.whitespaces)
            if lineString.count == 0 {
                continue
            }
            if lineString.hasPrefix("//") || lineString.hasPrefix("#") {
                continue
            }
            if lineString.contains(",") {
                let index=lineString.index(of: ",")!
                let key=lineString[..<index]
                let value=lineString[index...]
                dic[String(key)]=String(value)
            }
        }
        //NSLog(table["charset"]!)
    }
    
    func getStrValue(_ key:String) -> String? {
        return dic[key]
    }
}
