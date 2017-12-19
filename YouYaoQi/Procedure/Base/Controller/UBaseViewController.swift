//
//  UBaseViewController.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/19.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher

class UBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }

    func configUI() { }
    func configNavigationBar() {
        guard let navi = navigationController else {
            return
        }
        if navi.visibleViewController == self {
            navi
        }
    }

}
