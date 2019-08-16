//
//  ViewController.swift
//  GiftApp
//
//  Created by 中野湧仁 on 2019/08/15.
//  Copyright © 2019 中野湧仁. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var activityItems: Array<Any> = []
    var postImage: UIImage?
    var postURL: URL?
    var postText1: String?
    var postText2: String?
    var postText3: String?
    var commentText: String?
    
    
    // 最後にcompactMapでnilを除外
    var textArray: Array<String> = []
    
    let titleItems = [
        "アプリのURL",
        "なぜ使ってもらいたい?",
        "便利度",
        "革命度"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        setupTextView()
        setupImageView()
    }
    
    func setup() {
        tableView.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = false
        tableView.rowHeight = 84
    }

    @IBAction func endButtonTapped(_ sender: Any) {
        
        if let text1 = postText1 {
            let sentence1 = "なぜ使ってもらいたい?: \(text1)"
            textArray.append(sentence1)
        }
        
        if let text2 = postText2 {
            let sentence2 = "便利度: \(text2)"
            textArray.append(sentence2)
        }
        
        if let text3 = postText3 {
            let sentence3 = "革命度: \(text3)"
            textArray.append(sentence3)
        }
        
        if let comment = commentText {
            let commenSentence = "コメント: \(comment)"
            textArray.append(commenSentence)
        }
        
        let postText = textArray.map { $0 + "\n" }.joined()
        activityItems.append(postImage as Any)
        activityItems.append(postURL as Any)
        activityItems.append(postText)
        
//        let items = activityItems.compactMap { $0 }
//
        print(activityItems)

        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        
        resetData()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.popoverPresentationController?.sourceView = view
            activityVC.popoverPresentationController?.sourceRect = CGRect(
                x: view.frame.width,
                y: view.frame.height,
                width: 1, height: 1
            )
            activityVC.popoverPresentationController?.permittedArrowDirections = .down
        }
        
        present(activityVC, animated: true, completion: nil)
    }
}

extension ViewController: UITextViewDelegate {
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DataCell else { fatalError() }
        cell.delegate = self
        cell.textField.tag = indexPath.row
        cell.textField.addTarget(self, action: #selector(didEndEditing(_:)), for: .editingDidEnd)
        switch indexPath.row {
        case 0: cell.setupInputText()
        case 1: cell.setupPicker(pickerType: PickerType.sentence)
        case 2: cell.setupPicker(pickerType: PickerType.number)
        case 3: cell.setupPicker(pickerType: PickerType.number)
        default:()
        }
        cell.titleLabel.text = titleItems[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        guard let cell = tableView.cellForRow(at: indexPath) as? DataCell? else { fatalError() }


    }
}

extension ViewController {
    // tableviewのcellをタップするアクションがあったらtableviewを閉じさせる
    
    
    func setupTextView() {
        // ツールバー生成
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        // スタイルを設定
        toolBar.barStyle = UIBarStyle.default
        // 画面幅に合わせてサイズを変更
        toolBar.sizeToFit()
        // 閉じるボタンを右に配置するためのスペース?
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        // スペース、閉じるボタンを右側に配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        textView.inputAccessoryView = toolBar
        
    }
    
    func setupImageView() {
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func commitButtonTapped() {
        textView.endEditing(true)
        commentText = textView.text
    }
    
    @objc func didEndEditing(_ sender: UITextField) {
        // マジックナンバーをenumにする
        guard let text = sender.text else { return }
        switch sender.tag {
        case 0:
            postURL = URL(string: text)
        case 1:
            postText1 = text
        case 2:
            postText2 = text
        case 3:
            postText3 = text
        default: ()
        }
    }
    
    func resetData() {
        activityItems.removeAll()
    }
}

extension ViewController: DataCellDelegate {
    func passInputText(text: String) {
        print(text)
        postURL = URL(string: text)
    }
    
    func numberSelected(text: String, pickerNumber: Int) {
        print(text)
        postText2 = text
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        postImage = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
