//
//  FeedTableViewCell.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 23/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    
    // MARK: - Properties
    @IBOutlet weak var cellView: UIView!                // cell view
    @IBOutlet weak var shadowView: UIView!              // 그림자 뷰
    
    // 업로드 정보
    @IBOutlet weak var profileImageView: UIImageView!   // 프로필 이미지
    @IBOutlet weak var profileNameLabel: UILabel!       // 프로필 이름
    @IBOutlet weak var uploadTimeLabel: UILabel!        // 업로드 시간
    
    // 피드 영역
    @IBOutlet weak var thumbnailImageView: UIImageView! // 썸네일 이미지
    @IBOutlet weak var contentLabel: UILabel!           // 피드 내용
    
    // 버튼
    @IBOutlet weak var shareButton: UIButton!           // 공유하기
    @IBOutlet weak var editButton: UIButton!            // 수정하기
    @IBOutlet weak var trashButton: UIButton!           // 삭제하기
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initMemoCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - init
    func initMemoCell() {
        
        // 이미지 contentMode
        thumbnailImageView.contentMode = .scaleAspectFill
        
        // 프사 이미지 둥글게
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
    }
    
    // MARK: - Setting Cell
    public func setFeedCell(feed: Memo)
    {
        uploadTimeLabel.text = Util.formatter.string(for: feed.date)
        contentLabel.text = feed.content
        
        if let url = URL.loadFilePath(imageName: feed.imagePath!)
        {
            let provider = LocalFileImageDataProvider(fileURL: url)
            thumbnailImageView.kf.setImage(with: provider)
        }
    }
    

}
