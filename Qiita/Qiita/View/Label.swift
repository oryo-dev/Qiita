//
//  Label.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import Foundation
import UIKit

class Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(font: UIFont, color: UIColor) {
        super.init(frame: .zero)
        
        self.font = font
        self.textColor = color
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
