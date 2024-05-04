//
//  SidebarModel.swift
//  FootMark
//
//  Created by 윤성은 on 5/1/24.
//

import UIKit

struct SidebarModel {
    var image: UIImage?
    var title: String
}

extension SidebarModel {
    static func dummy() -> [[SidebarModel]]  {
        return [
            [SidebarModel(image: UIImage(named: "logo"), title: "FootMark")],
            [SidebarModel(image: UIImage.systemIcon(name: "person.fill"), title: "Profile"),
             SidebarModel(image: UIImage.systemIcon(name: "house"), title: "Home"),
             SidebarModel(image: UIImage.systemIcon(name: "calendar.badge.checkmark"), title: "Monthly Review"),
             SidebarModel(image: UIImage.systemIcon(name: "server.rack"), title: "Category")],
            [SidebarModel(image: UIImage.systemIcon(name: "rectangle.portrait.and.arrow.forward"), title: "Logout"),
             SidebarModel(image: UIImage.systemIcon(name: "bell"), title: "Notification"),
             SidebarModel(image: UIImage.systemIcon(name: "gearshape"), title: "Settings")]
        ]
    }
}
