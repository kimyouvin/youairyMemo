//
//  FeedDetailViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class FeedDetailViewController: BaseViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    
    var memo : Memo?
    var token : NSObjectProtocol?
    
    deinit
    {
        if let token = token
        {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UploadFeedViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.memoTableView.reloadData()})
        
    }
    
    @IBAction func deleteMemo(_ sender: Any)
    {
        let alert = UIAlertController(title: "삭제", message: "삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"삭제", style: .destructive)
        {
            [weak self] (action) in DataManager.shared.deleteMemo(self?.memo)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title:"취소", style: .cancel, handler:nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination.children.first as? UploadFeedViewController
        {
            vc.editTarget = memo
        }
    }
    
}

extension FeedDetailViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row
        {
        case 0 :
            let feedCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
            feedCell.setFeedCell(memo:memo!)
            return feedCell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for:indexPath)
            cell.textLabel?.text = Util.formatter.string(for: memo?.date)
            return cell
            
        default:
            fatalError()
        }
    }
    
}
