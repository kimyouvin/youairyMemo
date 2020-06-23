//
//  UploadFeedViewController.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import UIKit

class UploadFeedViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var imageDeleteButton: UIButton!
    @IBOutlet weak var imageSelectButton: UIButton!
    
    var editTarget : Memo?

    let imagePicker = UIImagePickerController()
    var imagePath: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initImagePicker()
        
        if let memo = editTarget
        {
            navigationItem.title = "메모 편집"
            memoTextView.text = editTarget?.content
        }
        else
        {
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
    }
    
    func initImagePicker() {
        self.imagePicker.delegate = self
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func save(_ sender: Any)
    {
        guard let text = memoTextView.text,
            text.count > 0 else {
                alert(message: "텍스트를 입력하세요")
                return
        }
        
        guard let path = imagePath,
            path.count > 0 else {
                alert(message: "사진을 선택하세요")
                return
        }
        
        if let target = editTarget // 피드 수정
        {
            target.content = text
            target.imagePath = imagePath
            DataManager.shared.saveContext()
            
            NotificationCenter.default.post(name:UploadFeedViewController.memoDidChange, object: nil)
        }
        else // 새 피드
        {
            DataManager.shared.addNewMemo(text:text, imagePath: imagePath)
            NotificationCenter.default.post(name:UploadFeedViewController.newMemoDidInsert, object: nil)
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func actionSelectImage(_ sender: Any)
    {
        openPhotoLibrary()
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 키보드 내리기
        self.view.endEditing(true)
        //        self.contentViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.30, animations: {
            self.view.layoutIfNeeded()
        })
        
        // 사진 불러오기 종료
        dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            guard let pickedImage = info[.originalImage] as? UIImage else { return }
            
            // 원본 저장
            self.imagePath = pickedImage.filePathCreate()
            
            let originalImage: UIImage = pickedImage.getOriginalImage()
//
            self.imagePath = originalImage.filePathCreate()
            self.uploadImageView.contentMode = .scaleToFill
            self.uploadImageView.image = originalImage
            
            // 이미지가 등록된 시점
            self.imageSelectButton.isHidden = true
            self.uploadImageView.isHidden = false
        })
    }
    
    // 사진앨범 열기
    func openPhotoLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
}

// MARK: - Notification 처리
extension UploadFeedViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}

//
//// MARK: - 사진첩 접근 관련
//extension UploadFeedViewController:  {
//
//
////    // 카메라 열기
////    func openCamera() {
////        imagePicker.allowsEditing = false
////
////        // 카메라 사용한 기기인지 확인
////        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
////            imagePicker.sourceType = .camera
////            present(imagePicker, animated: true, completion: nil)
////        } else {
////            print("CreateViewController - this device cannot use Camera")
////            let alert = UIAlertController(title:nil, message: "카메라를 지원하지 않습니다.", preferredStyle: .alert)
////
////            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
////            alert.addAction(cancel)
////            self.present(alert, animated: true, completion: nil)
////        }
////    }
////
//}
