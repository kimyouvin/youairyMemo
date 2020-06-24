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
    
    var feed : Memo?
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
    
    // 공유하기
    @IBAction func actionFeedCellShare(_ sender: Any)
    {
        sendLinkFeed(feed: feed!)
    }
    
    // 삭제하기
    @IBAction func actionFeedCellTrash(_ sender: Any)
    {
        let alert = UIAlertController(title: "삭제", message: "삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"삭제", style: .destructive)
        {
            [weak self] (action) in DataManager.shared.deleteFeed(self?.feed)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title:"취소", style: .cancel, handler:nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 수정하기
    @IBAction func actionFeedCellEdit(_ sender: Any)
    {
        guard let uploadFeedViewController: UploadFeedViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "UploadFeedViewController") as? UploadFeedViewController
            else { return }
        
        let navController = UINavigationController(rootViewController: uploadFeedViewController)
        uploadFeedViewController.editTarget = feed
        uploadFeedViewController.modalPresentationStyle = .pageSheet
        self.present(navController, animated:true, completion: nil)
    }
    
}

extension FeedDetailViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = tableView.dequeueReusableCell(withIdentifier: FeedDetailHeaderTableViewCell.identifier) as! FeedDetailHeaderTableViewCell
        headerView.setHeaderCell(feed: feed!)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let headerView = tableView.dequeueReusableCell(withIdentifier: FeedDetailHeaderTableViewCell.identifier)
        return headerView?.frame.height ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row
        {
        case 0 :
            let feedCell = tableView.dequeueReusableCell(withIdentifier: FeedDetailTableViewCell.identifier, for: indexPath) as! FeedDetailTableViewCell
            feedCell.setFeedCell(feed:feed!)
            
            let buttons = feedCell.subviews.filter{$0 is UIButton}
            for button in buttons
            {
                button.tag = indexPath.row
            }
            
            feedCell.trashButton.addTarget(self, action: #selector(self.actionFeedCellTrash(_:)), for: .touchUpInside)
            feedCell.shareButton.addTarget(self, action: #selector(self.actionFeedCellShare), for: .touchUpInside)
            feedCell.editButton.addTarget(self, action: #selector(self.actionFeedCellEdit(_:)), for: .touchUpInside)
            
            return feedCell
            
        default:
            fatalError()
        }
    }
    
}
