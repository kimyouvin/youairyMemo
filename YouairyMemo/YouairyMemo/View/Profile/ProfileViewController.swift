//
//  ProfileViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 2020/06/24.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!

    override func viewDidLoad() {
        feedCollectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "reusableView")

        super.viewDidLoad()

    }
    
}

extension ProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.feedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFeedCollectionViewCell.identifier, for: indexPath) as! ProfileFeedCollectionViewCell
        
        feedCell.setFeedCell(feed:DataManager.shared.feedList[indexPath.row])
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath)
            return headerView
        default:
            fatalError()
        }
    }
    
    
    //셀크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / 2) - 30
        
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
}

    

