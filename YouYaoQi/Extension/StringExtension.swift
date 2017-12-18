//
//  StringExtension.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/18.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}


