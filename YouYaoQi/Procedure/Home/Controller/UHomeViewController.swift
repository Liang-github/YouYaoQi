//
//  UHomeViewController.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/20.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import UIKit

class UHomeViewController: UPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"),
                                                            target: self,
                                                            action: #selector(selectAction))
    }
    
    @objc private func selectAction() {
        navigationController?.pushViewController(USearchViewController(), animated: true)
    }

}
