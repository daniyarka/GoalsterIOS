//
//  SphereModalView.swift
//  GOALSTER
//
//  Created by Daniyar on 8/17/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class SphereModalView: View {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(SphereCell.self, forCellReuseIdentifier: SphereCell.reuseIdentifier)
        view.delaysContentTouches = false
        view.separatorStyle = .none
        view.rowHeight = StaticSize.size(44)
        return view
    }()
    
    required init() {
        super.init(withBackButton: true)
        
        titleLabel.font = .primary(ofSize: StaticSize.size(22), weight: .semiBold)
        title = "Sphere choice".localized
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([tableView])
        
        tableView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(12))
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(withBackButton: Bool = false, iconImage: UIImage? = nil) {
        fatalError("init(withBackButton:iconImage:) has not been implemented")
    }
}

