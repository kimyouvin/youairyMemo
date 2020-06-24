//
//  UIViewController+Extension.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit


extension UIViewController {
    
    /*!
    * @abstract 통보성 alert "알림" , "확인"
    */
    func alert (title : String = "알림", message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
