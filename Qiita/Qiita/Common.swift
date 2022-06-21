//
//  Common.swift
//  Qiita
//
//  Created by oryo on 2022/06/21.
//

import Foundation
import UIKit

func getImage(url: String) -> UIImage {
    let url = URL(string: url)!
    do {
        let data = try Data(contentsOf: url)
        return UIImage(data: data)!
    } catch {
        print("error: \(error)")
    }
    return UIImage()
}

func nilCheck(string: String?, label: Label? = nil, button: Button? = nil) {
    if string == nil || string == "" {
        if label == nil {
            button?.isHidden = true
            return
        }
        
        label?.isHidden = true
        return
    }
    
    if label == nil {
        button?.isHidden = false
        button?.setTitle(string, for: .normal)
        return
    }
    
    label?.isHidden = false
    label?.text = string
}
