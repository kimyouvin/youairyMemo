//
//  ProfileFeedCollectionViewCell.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 2020/06/24.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var feedImageView : UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initFeedCell()
    }
    
    // MARK: - init
    func initFeedCell() {
        
        // 이미지 contentMode
        feedImageView.contentMode = .scaleAspectFill
        
    }
    
    // MARK: - Setting Cell
    public func setFeedCell(feed: Memo)
    {
        if let url = URL.loadFilePath(imageName: feed.imagePath!)
        {
            let provider = LocalFileImageDataProvider(fileURL: url)
            feedImageView?.kf.setImage(with: provider)
        }
    }
    
    
}
