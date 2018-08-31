//
//  ViewController.swift
//  magiLoadingPlaceHolder
//
//  Created by 安然 on 2018/7/30.
//  Copyright © 2018年 anran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func pushToSecVCAction(_ sender: UIButton) {
        let index = sender.tag - 100
        if index == 1 {
            performSegue(withIdentifier: "pushToTableViewController", sender: nil)
        }
        else if index == 2 {
            performSegue(withIdentifier: "pushToCollectionViewController", sender: nil)
        }
        else if index == 3 {
            performSegue(withIdentifier: "pushToWebViewController", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

