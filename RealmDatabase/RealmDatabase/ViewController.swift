//
//  ViewController.swift
//  RealmDatabase
//
//  Created by 王 on 2017/07/10.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let team = Team()
        team.city = "Tokyo"
        team.nickname = "TK"
        
        do{
            try realm.write {
                realm.add(team)
            }
        }catch{
            print("realm write fail")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

