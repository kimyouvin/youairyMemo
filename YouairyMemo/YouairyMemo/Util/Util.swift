//
//  Common.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 22/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import Foundation

class Util {
    
    static let formatter :DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
//        f.locale = Locale(identifier: "KO_kr")
        return f
    }()
    
}

