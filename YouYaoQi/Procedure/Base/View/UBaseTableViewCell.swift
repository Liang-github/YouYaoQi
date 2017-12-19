//
//  UBaseTableViewCell.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/19.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import UIKit
import Reusable
class UBaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func configUI() {
        
    }
    
}
