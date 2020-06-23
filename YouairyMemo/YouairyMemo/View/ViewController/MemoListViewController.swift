//
//  MemoListViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class MemoListViewController: BaseViewController
{
    
    @IBOutlet weak var memoListTableView: UITableView!
    
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
        
        token = NotificationCenter.default.addObserver(forName: UploadFeedViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) {[weak self] (noti) in self?.memoListTableView.reloadData() }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        DataManager.shared.fetchMemo()
        memoListTableView.reloadData()
    }
    
}


// MARK: - Table view
extension MemoListViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DataManager.shared.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let feedCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        feedCell.setFeedCell(memo:DataManager.shared.memoList[indexPath.row])
        
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
            let target = DataManager.shared.memoList[indexPath.row]
            DataManager.shared.deleteMemo(target)
            DataManager.shared.memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let FeedDetailViewController: FeedDetailViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "FeedDetailViewController") as? FeedDetailViewController
                else { return }
        
        FeedDetailViewController.memo = DataManager.shared.memoList[indexPath.row]
        FeedDetailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(FeedDetailViewController, animated: true)
    }
    
}
