//
//  BaseViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 22/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit
import Kingfisher
import KakaoLink
import KakaoMessageTemplate

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*!
    * @abstract 카카오톡 공유하기
    */
    func sendLinkFeed(feed:Memo)
    {
        
        // Feed 타입 템플릿 오브젝트 생성
        let template = KMTFeedTemplate { (feedTemplateBuilder) in
            
            // 컨텐츠
            feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                contentBuilder.title = "YOUAIRY"
                contentBuilder.desc = feed.content
                contentBuilder.imageURL = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTvvsdMhyhdzcrZVp_Ps6_nB3qN8OwVNyQ_NQ&usqp=CAU")!
                contentBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                    linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")
                })
            })
            
            // 소셜
            feedTemplateBuilder.social = KMTSocialObject(builderBlock: { (socialBuilder) in
                socialBuilder.likeCount = 286
                socialBuilder.commnentCount = 45
                socialBuilder.sharedCount = 845
            })
            
            // 버튼
            feedTemplateBuilder.addButton(KMTButtonObject(builderBlock: { (buttonBuilder) in
                buttonBuilder.title = "자세히 보기"
                buttonBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                    linkBuilder.iosExecutionParams = "param1=value1&param2=value2"
                    linkBuilder.androidExecutionParams = "param1=value1&param2=value2"
                })
            }))
        }
        
        // 서버에서 콜백으로 받을 정보
        let serverCallbackArgs = ["user_id": "abcd",
                                  "product_id": "1234"]

        // 카카오링크 실행
        KLKTalkLinkCenter.shared().sendDefault(with: template, serverCallbackArgs: serverCallbackArgs, success: { (warningMsg, argumentMsg) in
            
            // 성공
            print("warning message: \(String(describing: warningMsg))")
            print("argument message: \(String(describing: argumentMsg))")
            
        }, failure: { (error) in
            
            // 실패
            //            UIAlertController.showMessage(error.localizedDescription) // YOUVIN 에러나길래 일단 주석처리함
            print("error \(error)")

            
        })

    }
    

}

