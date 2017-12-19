//
//  UBaseCollectionViewCell.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/19.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import UIKit
import Reusable

class UBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func configUI() {
        
    }
}
