//
//  DataListViewController.swift
//  SQLiteLibrary
//
//  Created by 王 on 2017/07/09.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import UIKit

class DataListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var dataListView: UITableView!
    var dataSource:[Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataListView.register(UINib(nibName: "DataListTableViewCell", bundle: nil), forCellReuseIdentifier: "DataListTableViewCell")
        
        let listShowNoti = Notification.Name("DataListViewWillShow")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadListDatas), name: listShowNoti, object: nil)
        reloadListDatas()
    }
    
    func reloadListDatas()  {
        do{
            dataSource = try TeamDataHelper.findAll()!
            dataListView.reloadData()
        }catch{
            dataSource = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("List View Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("List View Did Appear")
    }
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:DataListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "DataListTableViewCell", for: indexPath) as! DataListTableViewCell
        
        if cell==nil {
            cell = DataListTableViewCell(style: .default, reuseIdentifier: "DataListTableViewCell")
        }
        
        let team = dataSource[indexPath.row]
        cell.teamIdLabel.text = String(describing: team.teamId!)
        cell.teamCityLabel.text = team.city
        cell.teamNickNameLabel.text = team.nickName
        cell.teamAbbreviationLabel.text = team.abbreviation
        return cell
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
