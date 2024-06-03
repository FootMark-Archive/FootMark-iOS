//
//  SidebarView.swift
//  FootMark
//
//  Created by 윤성은 on 5/1/24.
//

import UIKit
import SnapKit

class SidebarView: BaseView {
    
    var tableView = UITableView().then() {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        $0.separatorStyle = .none
    }
    
    override func setLayout() {
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func register() {
        tableView.register(
            SidebarViewCell.self,
            forCellReuseIdentifier: SidebarViewCell.identifier
        )
    }
}
