//
//  FeedListViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class FeedListViewController: BaseViewController
{
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var token : NSObjectProtocol? // Notification token
    
    deinit {
        if let token = token
        {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: UploadFeedViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) {[weak self] (noti) in self?.feedTableView.reloadData() }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        DataManager.shared.fetchFeed()
        feedTableView.reloadData()
    }
    
    
    // MARK: - action
    
    // 프로필
    @IBAction func actionProfile(_ sender: UIButton)
    {
        guard let profileViewController: ProfileViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            else { return }
        
        profileViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // 공유하기
    @IBAction func actionFeedCellShare(_ sender: UIButton)
    {
        let index = sender.tag
        let target = DataManager.shared.feedList[index]
        
        sendLinkFeed(feed: target)
    }
    
    // 삭제하기
    @IBAction func actionFeedCellTrash(_ sender: UIButton)
    {
        let index = sender.tag
        let target = DataManager.shared.feedList[index]
        DataManager.shared.deleteFeed(target)
        DataManager.shared.feedList.remove(at: index)
        
        let indexPath = IndexPath(item: index, section: 0)
        feedTableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    // 수정하기
    @IBAction func actionFeedCellEdit(_ sender: UIButton)
    {
        guard let uploadFeedViewController: UploadFeedViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "UploadFeedViewController") as? UploadFeedViewController
            else { return }
        
        let index = sender.tag
        let target = DataManager.shared.feedList[index]
        
        let navController = UINavigationController(rootViewController: uploadFeedViewController)
        uploadFeedViewController.editTarget = target
        uploadFeedViewController.modalPresentationStyle = .pageSheet
        self.present(navController, animated:true, completion: nil)
    }
    
}


// MARK: - Table view
extension FeedListViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DataManager.shared.feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let feedCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        feedCell.setFeedCell(feed:DataManager.shared.feedList[indexPath.row])
        
        let buttons = feedCell.subviews.filter{$0 is UIButton}
        for button in buttons
        {
            button.tag = indexPath.row
        }
        
        feedCell.trashButton.addTarget(self, action: #selector(self.actionFeedCellTrash(_:)), for: .touchUpInside)
        feedCell.shareButton.addTarget(self, action: #selector(self.actionFeedCellShare(_:)), for: .touchUpInside)
        feedCell.editButton.addTarget(self, action: #selector(self.actionFeedCellEdit(_:)), for: .touchUpInside)
        
        
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            let target = DataManager.shared.feedList[indexPath.row]
            DataManager.shared.deleteFeed(target)
            DataManager.shared.feedList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let feedDetailViewController: FeedDetailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "FeedDetailViewController") as? FeedDetailViewController
            else { return }
        
        feedDetailViewController.feed = DataManager.shared.feedList[indexPath.row]
        feedDetailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
}
