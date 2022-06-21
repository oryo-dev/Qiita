//
//  View.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import Foundation
import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
