//
//  Button.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import Foundation
import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(title: String, tag: Int? = nil) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        self.backgroundColor = UIColor.rgb(red: 116, green: 193, blue: 58)
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        
        if let tag = tag {
            self.tag = tag
            self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            switch tag {
            case 1:
                createButton(imageName: "facebook", color: UIColor.rgb(red: 46, green: 103, blue: 236))
            case 2:
                createButton(imageName: "github", color: UIColor.rgb(red: 30, green: 30, blue: 30))
            case 3:
                createButton(imageName: "linkedin", color: UIColor.rgb(red: 39, green: 104, blue: 170))
            case 4:
                createButton(imageName: "twitter", color: UIColor.rgb(red: 59, green: 146, blue: 237))
            case 5:
                createButton(imageName: "website", color: UIColor.rgb(red: 148, green: 148, blue: 148))
            default:
                return
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButton(imageName: String, color: UIColor) {
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setTitleColor(color, for: .normal)
        self.layer.borderColor = color.cgColor
    }
}
