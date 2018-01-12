//
//  ViewController.swift
//  TextFieldInputSeparate
//
//  Created by 蜂谷庸正 on 2018/01/12.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var setNumLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        // キーボードを数値入力に固定
        textField.keyboardType = .decimalPad
        
        // 3桁ごとにカンマ区切りするフォーマット
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        setNumLabel.text = formatter.string(from: 9999)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textFieldValue = textField.text, let labelValue = setNumLabel.text {
            if !isValidInput(base: labelValue, target: textFieldValue + string) {
                return false
            }
        }
        
        return true
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        sender.text = addComma(str: removeComma(str: sender.text!))
        calc()
    }
    
    // カンマ区切りに変換（表示用）
    func addComma(str: String) -> String {
        if str != "" {
            if let num = Int(str) {
                return formatter.string(from: num as NSNumber)!
            }
        }
        
        return ""
    }

    // カンマ区切りを削除（計算用）
    func removeComma(str: String) -> String {
        let tmp = str.replacingOccurrences(of: ",", with: "")
        return tmp
    }

    // ラベルに表示
    func calc() {
        if textField.text != "" {
            let input = removeComma(str: textField.text ?? "0")
            let num = Int(input) ?? 0
            changeLabel.text = addComma(str: String(num))
        } else {
            changeLabel.text = "0"
        }
    }
    
    func isValidInput(base: String, target: String) -> Bool {

        let baseVal = removeComma(str: base)
        let targetVal = removeComma(str: target)
        
        if let baseNum = Int(baseVal), let targetNum = Int(targetVal) {
            if baseNum < targetNum {
                return false
            }
        }

        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

