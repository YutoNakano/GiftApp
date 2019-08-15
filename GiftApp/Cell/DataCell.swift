//
//  DataCell.swift
//  GiftApp
//
//  Created by 中野湧仁 on 2019/08/15.
//  Copyright © 2019 中野湧仁. All rights reserved.
//

import UIKit

final class DataCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {

    }
}
