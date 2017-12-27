//
// Created by 刘硕 on 2017/12/27.
// Copyright (c) 2017 ___FULLUSERNAME___. All rights reserved.
//

import UIKit

class NumbertailGameController : UIViewController {
    var demension : Int  //2048游戏中每行每列含有多少个块
    var threshold : Int  //最高分数，判断输赢时使用，今天暂时不会用到，预留
    let boardWidth: CGFloat = 260.0  //游戏区域的长度和高度
    let thinPadding: CGFloat = 3.0  //游戏区里面小块间的间距
    let viewPadding: CGFloat = 10.0  //计分板和游戏区块的间距
    let verticalViewOffset: CGFloat = 0.0  //一个初始化属性，后面会有地方用到

    init(demension d: Int, threshold t: Int){
        demension = d < 2 ? 2 : d
        threshold = t < 8 ? 8 : t
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(red : 0xE6/255, green : 0xE2/255, blue : 0xD4/255, alpha : 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }

    func setupGame(){
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        //获取游戏区域左上角那个点的x坐标
        func xposition2Center(view v : UIView) -> CGFloat{
            let vWidth = v.bounds.size.width
            return 0.5*(viewWidth - vWidth)

        }
        //获取游戏区域左上角那个点的y坐标
        func yposition2Center(order : Int , views : [UIView]) -> CGFloat {
            assert(views.count > 0)
            let totalViewHeigth = CGFloat(views.count - 1)*viewPadding +
                    views.map({$0.bounds.size.height}).reduce(verticalViewOffset, {$0 + $1})
            let firstY = 0.5*(viewHeight - totalViewHeigth)

            var acc : CGFloat = 0
            for i in 0..<order{
                acc += viewPadding + views[i].bounds.size.height
            }
            return acc + firstY
        }
        //获取具体每一个区块的边长，即：(游戏区块长度-间隙总和)/块数
        let width = (boardWidth - thinPadding*CGFloat(demension + 1))/CGFloat(demension)
        //初始化一个游戏区块对象
        let gamebord = GamebordView(
                demension : demension,
                titleWidth: width,
                titlePadding: thinPadding,
                backgroundColor:  UIColor(red : 0x90/255, green : 0x8D/255, blue : 0x80/255, alpha : 1),
                foregroundColor:UIColor(red : 0xF9/255, green : 0xF9/255, blue : 0xE3/255, alpha : 0.5)
        )
        //现在面板中所有的视图对象，目前只有游戏区块，后续加入计分板
//        let views = [gamebord]
        //设置游戏区块在整个面板中的的绝对位置，即左上角第一个点
//        var f = gamebord.frame
//        f.origin.x = xposition2Center(view: gamebord)
//        f.origin.y = yposition2Center(order: 0, views: views)
//        gamebord.frame = f
//        //将游戏对象加入当前面板中
//        view.addSubview(gamebord)

        let scoreView = ScoreView(
                backgroundColor: UIColor(red : 0xA2/255, green : 0x94/255, blue : 0x5E/255, alpha : 1),
                textColor: UIColor(red : 0xF3/255, green : 0xF1/255, blue : 0x1A/255, alpha : 0.5),
                font: UIFont(name: "HelveticaNeue-Bold", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        )
        let views = [scoreView, gamebord]
        var sf = scoreView.frame
        sf.origin.x = xposition2Center(view: scoreView)
        sf.origin.y = yposition2Center(order: 0, views: views)
        var gf = gamebord.frame
        gf.origin.x = xposition2Center(view: gamebord)
        gf.origin.y = yposition2Center(order: 0, views: views)
        scoreView.frame = sf
        gamebord.frame = gf
        view.addSubview(scoreView)
        view.addSubview(gamebord)
        scoreView.scoreChanged(newScore: 11)
    }
}