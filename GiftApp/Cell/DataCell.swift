//
//  DataCell.swift
//  GiftApp
//
//  Created by 中野湧仁 on 2019/08/15.
//  Copyright © 2019 中野湧仁. All rights reserved.
//

import UIKit

enum PickerType {
    case number
    case sentence
}

protocol DataCellDelegate: class {
    func passInputText(text: String)
    func numberSelected(text: String, pickerNumber: Int)
}

final class DataCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let numberItems = [
        "1",
        "2",
        "3",
        "4",
        "5"
    ]
    
    let sentencesItems = [
        "あなたに便利そう",
        "一緒に使いたい",
        "なんとなく"
    ]
    
    fileprivate class SentencePickerView: UIPickerView { }
    fileprivate class NumberPickerView: UIPickerView { }
    
    weak var delegate: DataCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        textField.addTarget(self, action: #selector(didEndEditing(_:)), for: .editingDidEnd)
    }
    
    func setupPicker(pickerType: PickerType) {
        let pickerView = setPickerType(type: pickerType)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPicker))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.textField.inputView = pickerView
        self.textField.inputAccessoryView = toolbar
    }
    
    func setupInputText() {
        textField.delegate = self
    }
    
}

extension DataCell {
    @objc func donePicker() {
        textField.endEditing(true)
    }
    
    @objc func cancelPicker() {
        textField.endEditing(true)
    }
    
//    @objc func didEndEditing(_ sender: UITextField) {
//        guard let text = sender.text else { return }
//        if text.count <= 2 {
//            delegate?.passInputText(text: text)
//        } else {
//            delegate?.numberSelected(text: text, pickerNumber: <#Int#>)
//        }
//    }
}

extension DataCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is SentencePickerView:
            return sentencesItems.count
        case is NumberPickerView:
            return numberItems.count
        default: return 0
        }
    }
}

extension DataCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is SentencePickerView:
            return sentencesItems[row]
        case is NumberPickerView:
            return numberItems[row]
        default: return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is SentencePickerView:
            return textField.text = sentencesItems[row]
        case is NumberPickerView:
            return textField.text = numberItems[row]
        default:()
        }
        textField.text = numberItems[row]
//        delegate?.numberSelected(text: textField.text ?? "")
        textField.endEditing(true)
    }
}

extension DataCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension DataCell {
    func setPickerType(type: PickerType) -> UIPickerView {
        switch type {
        case .sentence:
            let sentencePickerView = SentencePickerView()
            return sentencePickerView
        case .number:
            let numberPickerView = NumberPickerView()
            return numberPickerView
        }
    }
}
