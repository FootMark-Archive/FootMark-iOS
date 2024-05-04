//
//  SidebarView.swift
//  FootMark
//
//  Created by 윤성은 on 5/1/24.
//

import UIKit

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
            $0.leading.equalToSuperview().offset(16)
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
    }
}

extension UIImage {
    static func systemIcon(name: String, tintColor: UIColor = .black) -> UIImage? {
        guard let image = UIImage(systemName: name) else { return nil }
        return image.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }

    func withLeftPadding(_ padding: CGFloat) -> UIImage? {
        let newSize = CGSize(width: self.size.width + padding, height: self.size.height)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let newImage = renderer.image { (context) in
            self.draw(at: CGPoint(x: padding, y: 0))
        }
        
        return newImage
    }
}
