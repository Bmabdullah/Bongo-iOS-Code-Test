//
//  ViewController.swift
//  BongoIOSCodeTest
//
//  Created by AL Mustakim on 27/7/20.
//  Copyright © 2020 AL Mustakim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clickButtonOutlet: UIButton!
    
    @IBOutlet weak var txtfld: UITextView!
    
    var newText = String()
    
    var lastChar = ""
    var tenthChar = ""
    var wordCount = "\n"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonDesign()
        
    }
    
    @IBAction func clickButton(_ sender: Any) {
        
        apicall()
    }
}


extension ViewController{
    
    func apicall() {
        
        if let url = URL(string: "https://bongobd.com/disclaimer") {
            do {
                let contents = try String(contentsOf: url)
                
                let attributedString = contents.data(using: .utf8).flatMap { data -> NSAttributedString? in
                    return try? NSAttributedString(
                        data: data,
                        options: [
                            .documentType: NSAttributedString.DocumentType.html,
                            .characterEncoding: String.Encoding.utf8.rawValue
                        ],
                        documentAttributes: nil)
                }
                guard let attrString = attributedString else { return }
                
                let stringfromServer = attrString.description.html2AttributedString
                
                
                StringOperation(str: stringfromServer ?? "")
                
            } catch {
                
            }
        } else {
            print("Wrong URL")
        }
    }
}

extension ViewController {
    func StringOperation(str : String) {
        
        lastChar = String(str.last!)
        print(lastChar)
        
        let c = NSCharacterSet(charactersIn: " ,.!?;\"/<>{}\\=0123456789()")
        let a = str.components(separatedBy: c as CharacterSet).filter({!$0.isEmpty})
        
        
        var i : Int = 0
        
        
        for _ in 1...a.count{
            
            wordCount = "\(wordCount) \(a[i]) : \(a[i].count) char \n"
            i+=1
        }
        for (index, character) in str.enumerated() {
            if index != 0 && index % 10 == 0 {
                
                tenthChar = " \(tenthChar) \(String(newText.last!)) \n"
            }
            newText.append(String(character))
        }
        
        print(lastChar)
        print("print Every 10th char")
        print(tenthChar)
        print(wordCount)
        
        txtfld.text = " l) The last character is : \t \" \(String(describing: lastChar)) \" \n 2) Every 10th character :\n \t  \(tenthChar) \n  3) The count of every word: \n \t \(wordCount) "
        
    }
}
