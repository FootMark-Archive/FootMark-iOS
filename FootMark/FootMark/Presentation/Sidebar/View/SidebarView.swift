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
            SidebarTableViewCell.self,
            forCellReuseIdentifier: SidebarTableViewCell.identifier
        )
    }
}

final class SidebarTableViewCell: UITableViewCell {
    
    static let identifier = "SidebarTableViewCell"
    var tableImageViewLeadingConstraint: Constraint?
    
    let tableImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let tableLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Bold", size: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [tableImageView, tableLabel].forEach {
            contentView.addSubview($0)
        }
        
        tableImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            self.tableImageViewLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
            $0.size.equalTo(45)
        }
        
        tableLabel.snp.makeConstraints {
            $0.centerY.equalTo(tableImageView.snp.centerY)
            $0.leading.equalTo(tableImageView.snp.trailing).offset(16)
        }
    }
    
    func dataBind(_ sidebarData: SidebarModel) {
        tableImageView.image = sidebarData.image
        tableLabel.text = sidebarData.title
        
        if sidebarData.title == "Logout" {
            tableImageViewLeadingConstraint?.update(offset: 20)
        } else {
            tableImageViewLeadingConstraint?.update(offset: 16)
        }
    }
}

extension UIImage {
    static func systemIcon(name: String, tintColor: UIColor = .black, weight: UIImage.SymbolWeight = .regular) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(weight: weight)
        guard let image = UIImage(systemName: name, withConfiguration: configuration) else { return nil }
        return image.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }
}

