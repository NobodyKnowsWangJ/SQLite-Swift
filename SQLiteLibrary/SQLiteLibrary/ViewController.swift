//
//  ViewController.swift
//  SQLiteLibrary
//
//  Created by 王 on 2017/07/09.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segementView: UISegmentedControl!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var dataInputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.isHidden = false
        dataInputView.isHidden = true
        
        let notification = Notification.Name("CancelInputNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewWithSegment), name: notification, object: nil)
    }
    
    func switchViewWithSegment() {
        segementView.selectedSegmentIndex = 0
        listView.isHidden = false
        dataInputView.isHidden = true
    }
    
    @IBAction func segementValueChanged(_ sender: UISegmentedControl) {
        if segementView.selectedSegmentIndex==0 {
            listView.isHidden = false
            dataInputView.isHidden = true
        }else{
            listView.isHidden = true
            dataInputView.isHidden = false
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

