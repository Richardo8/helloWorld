//
//  ViewController.swift
//  helloWorld
//
//  Created by 刘硕 on 2017/12/27.
//  Copyright © 2017 刘硕. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let game = NumbertailGameController(demension: 4, threshold: 2048)
        self.present(game, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
