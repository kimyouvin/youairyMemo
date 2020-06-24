//
//  FeedDetailHeaderTableViewCell.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 2020/06/23.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class FeedDetailHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!   // 프로필 이미지
    @IBOutlet weak var profileNameLabel: UILabel!       // 프로필 이름
    @IBOutlet weak var uploadTimeLabel: UILabel!        // 업로드 시간
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initHeaderCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - init
    func initHeaderCell() {
        
        // 프사 이미지 둥글게
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
    }
    
    // MARK: - Setting Cell
    public func setHeaderCell(feed: Memo)
    {
        uploadTimeLabel.text = Util.formatter.string(for: feed.date)
    }
    
}
