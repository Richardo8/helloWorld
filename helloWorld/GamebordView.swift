//
// Created by 刘硕 on 2017/12/27.
// Copyright (c) 2017 ___FULLUSERNAME___. All rights reserved.
//

import UIKit

class GamebordView: UIView{
    var demension: Int
    var tileWidth: CGFloat
    var tilePadding: CGFloat
    let provider = AppearanceProvider()

    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
    let tilePopDelay: TimeInterval = 0.05
    let tileExpandTime: TimeInterval = 0.18
    let tileContractTime: TimeInterval = 0.08

    let tileMergeStartScale: CGFloat = 1.0
    let tileMergeExpandTime: TimeInterval = 0.08
    let tileMergeContractTime: TimeInterval = 0.08

    let perSquareSlideDuration: TimeInterval = 0.08
    var tiles: Dictionary<NSIndexPath, TileView>
    init(demension d: Int, titleWidth width: CGFloat, titlePadding padding: CGFloat, backgroundColor : UIColor, foregroundColor : UIColor){
        demension = d
        tileWidth = width
        tilePadding = padding
        tiles = Dictionary()
        let totalWidth = tilePadding + CGFloat(demension)*(tilePadding + tileWidth)
        super.init(frame: CGRect(x: 0, y: 0, width: totalWidth, height: totalWidth))
        setColor(backgroundColor: backgroundColor, foregroundColor: foregroundColor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setColor(backgroundColor bgcolor: UIColor, foregroundColor forecolor: UIColor){
        self.backgroundColor = bgcolor
        var xCursor = tilePadding
        var yCursor: CGFloat

        for _ in 0..<demension{
            yCursor = tilePadding
            for _ in 0..<demension {
                let tileFrame = UIView(frame: CGRect(x: xCursor, y: yCursor, width: tileWidth, height: tileWidth))
                tileFrame.backgroundColor = forecolor
                tileFrame.layer.cornerRadius = 8
                addSubview(tileFrame)
                yCursor += tilePadding + tileWidth
            }
            xCursor += tilePadding + tileWidth
        }
    }

    func insertTile(pos: (Int, Int), value: Int){
        assert(positionIsValied(position: pos))
        let (row, col) = pos
        let x = tilePadding + CGFloat(row)*(tilePadding + tileWidth)
        let y = tilePadding + CGFloat(col)*(tilePadding + tileWidth)
        let tileView = TileView(position: CGPoint(x: x, y: y), width: tileWidth, value: value, delegate: provider)
        addSubview(tileView)
        bringSubview(toFront: tileView)

        tiles[NSIndexPath(row: row, section: col)] = tileView
        UIView.animate(withDuration: tileExpandTime, delay: tilePopDelay, options: [],
                animations: {
                    tileView.layer.setAffineTransform(CGAffineTransform.init(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))

                }, completion: { finished in
            UIView.animate(withDuration: self.tileContractTime, animations: { () -> Void in
                tileView.layer.setAffineTransform(CGAffineTransform.identity)
            })
        })
    }

    func positionIsValied(position: (Int, Int)) -> Bool{
        let (x, y) = position
        return x >= 0 && x < demension && y >= 0 && y < demension
    }

}
