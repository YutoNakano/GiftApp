//
//  ViewController.swift
//  GiftApp
//
//  Created by 中野湧仁 on 2019/08/15.
//  Copyright © 2019 中野湧仁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var postImage: UIImage?
    var postText: String? = "このアプリめっちゃいいよ!\nぜひダウンロードしてみてね!!"
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    let titleItems = [
        "アプリのURL",
        "なぜ使ってもらいたい?",
        "便利度",
        "革命度"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImage = UIImage(named: "sample")
        // Do any additional setup after loading the view.
        setup()
        setupTextView()
    }
    
    func setup() {
        tableView.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = false
        tableView.rowHeight = 84
    }

    @IBAction func endButtonTapped(_ sender: Any) {
//        let urlText = textField.text!
//        let url = URL(string: urlText)
        let activityItems: Array<Any> = [postImage!,postText!]

        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
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
    
    
    @objc func commitButtonTapped() {
        
    }
}

extension ViewController: DataCellDelegate {
    func passInputText(text: String) {
        print(text)
    }
    
    func numberSelected(text: String) {
        print(text)
    }
}
