//
//  URL+Extension.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 23/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

extension URL {
    // 파일 경로 불러오기
    static func loadFilePath(imageName: String) -> URL? {
        let fileManager = FileManager.default
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let strPath = documentDirectory.appending("/\(imageName)")
        
        if fileManager.fileExists(atPath: strPath) {
            let fileURL = URL(fileURLWithPath: strPath)
            return fileURL
        } else {
            print("Error loading image")
        }
        
        return nil
    }
}
