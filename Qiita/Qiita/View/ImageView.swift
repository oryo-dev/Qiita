//
//  ImageView.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import Foundation
import UIKit

class ImageView: UIImageView {
    
    init(image: UIImage) {
        super.init(frame: .zero)
        
        self.image = image
    }
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
