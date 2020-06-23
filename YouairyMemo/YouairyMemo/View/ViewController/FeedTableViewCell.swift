//
//  FeedTableViewCell.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 23/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Properties
    @IBOutlet weak var cellView: UIView!                // cell view
    @IBOutlet weak var shadowView: UIView!              // 그림자 뷰
    
    // 올린 사람 정보
    @IBOutlet weak var profileImageView: UIImageView!   // 프로필 이미지
    @IBOutlet weak var profileNameLabel: UILabel!       // 프로필 이름
    @IBOutlet weak var uploadTimeLabel: UILabel!        // 업로드 시간
    
    // 피드 내용
    @IBOutlet weak var thumbnailImageView: UIImageView! // 썸네일 이미지
    @IBOutlet weak var contentLabel: UILabel!           // 피드 내용
    
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
        // 셀 선택 시 스타일
        //selectionStyle = .none
        
        // 이미지 contentMode
        thumbnailImageView.contentMode = .scaleAspectFill
        
        // 프사 이미지 둥글게
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
//        // 그림자
//        shadowView.layer.masksToBounds = false
//        shadowView.layer.cornerRadius = shadowView.frame.width/12
//        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
//        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
//        shadowView.layer.shadowOpacity = 0.2
        
    }
    
    // MARK: - Setting Cell
    public func setFeedCell(memo: Memo)
    {
        uploadTimeLabel.text = Util.formatter.string(for: memo.date)
        contentLabel.text = memo.content

//        if let content = memo.content
//        {
//            contentLabel.text = memo.content
//        }
//        else
//        {
//            contentLabel.text = ""
//        }
        
        
//        if let url = URL.loadFilePath(imageName: info.memoMediaPath) {
//            let provider = LocalFileImageDataProvider(fileURL: url)
//            thumbnailImageView.kf.setImage(with: provider)
//        }
    }

}
