//
//  NewMemoViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class NewMemoViewController: UIViewController {
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let memo = memoTextView.text,
            memo.count > 0 else {
                alert(message: "메모를 입력하세요")
                return
        }
        
        let newMemo = Memo(content: memo)
        Memo.dummyDataList.append(newMemo)
        NotificationCenter.default.post(name:NewMemoViewController.newMemoDidInsert, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewMemoViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
}
