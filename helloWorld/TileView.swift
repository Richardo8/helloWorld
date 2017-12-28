//
// Created by 刘硕 on 2017/12/28.
// Copyright (c) 2017 ___FULLUSERNAME___. All rights reserved.
//

import UIKit

class TileView: UIView{
    var value: Int = 0 {
        didSet{
            backgroundColor = delegate.tileColor(value: value)
            lable.textColor = delegate.numberColor(value: value)
            lable.text = "\(value)"
        }
    }
    unowned let delegate: AppearanceProviderProtocol
    var lable: UILabel

    init(position: CGPoint, width: CGFloat, value: Int, delegate d: AppearanceProviderProtocol){
        delegate = d
        lable = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        lable.textAlignment = NSTextAlignment.center
        lable.minimumScaleFactor = 0.5
        lable.font = UIFont(name: "HelveticaNeue-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        addSubview(lable)
        lable.layer.cornerRadius = 6

        self.value = value
        backgroundColor = delegate.tileColor(value: value)
        lable.textColor = delegate.numberColor(value: value)
        lable.text = "\(value)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
