//
//  FeedDetailTableViewCell.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 2020/06/23.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit
import Kingfisher

class FeedDetailTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // 피드 영역
    @IBOutlet weak var thumbnailImageView: UIImageView! // 썸네일 이미지
    @IBOutlet weak var contentLabel: UILabel!           // 피드 내용
    
    // 버튼
    @IBOutlet weak var shareButton: UIButton!           // 공유하기
    @IBOutlet weak var editButton: UIButton!            // 수정하기
    @IBOutlet weak var trashButton: UIButton!           // 삭제하기
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initFeedCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - init
    func initFeedCell() {
        
        // 이미지 contentMode
        thumbnailImageView.contentMode = .scaleAspectFill
        
    }
    
    // MARK: - Setting Cell
    public func setFeedCell(feed: Memo)
    {
        contentLabel.text = feed.content
        
        if let url = URL.loadFilePath(imageName: feed.imagePath!)
        {
            let provider = LocalFileImageDataProvider(fileURL: url)
            thumbnailImageView.kf.setImage(with: provider)
        }
    }
    

}
