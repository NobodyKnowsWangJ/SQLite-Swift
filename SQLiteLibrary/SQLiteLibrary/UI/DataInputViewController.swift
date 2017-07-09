//
//  DataInputViewController.swift
//  SQLiteLibrary
//
//  Created by 王 on 2017/07/09.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import UIKit

class DataInputViewController: UIViewController {

    @IBOutlet weak var cityTextFierld: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var abbreviteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    func viewTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func saveDataToDataBasw(_ sender: UIButton) {
        self.view.endEditing(true)
        do{
            try TeamDataHelper.createTable()
        }catch{
            print("Create Team table Error!")
        }
        
        let city = cityTextFierld.text
        let cityStatus = city==nil || city==""
        
        let nickName = nickNameTextField.text
        let nickNameStatus = nickName==nil || nickName==""
        
        let abbreviation = abbreviteTextField.text
        let abbreStatus = abbreviation==nil || abbreviation==""
        
        guard !cityStatus else {
            showErrorAlert(error: saveError.City_Nil_Error)
            return
        }
       
        guard !nickNameStatus else {
            showErrorAlert(error: saveError.NickName_Nil_Error)
            return
        }
        guard !abbreStatus else {
            showErrorAlert(error: saveError.Abbreviate_Nil_Error)
            return
        }
        
        do{
            let torId = try TeamDataHelper.insert(item:
                Team(
                    teamId: 0,
                    city: city,
                    nickName: nickName,
                    abbreviation: abbreviation
                )
            )
            print(torId)
        }catch{
            print("Data Insert Error!")
            return
        }
        
        let notification = Notification.Name("CancelInputNotification")
        NotificationCenter.default.post(name: notification, object: nil)
        cityTextFierld.text = ""
        nickNameTextField.text = ""
        abbreviteTextField.text = ""
    }
    
    @IBAction func cancelInput(_ sender: UIButton) {
        self.view.endEditing(true)
        let notification = Notification.Name("CancelInputNotification")
        NotificationCenter.default.post(name: notification, object: nil)
        cityTextFierld.text = ""
        nickNameTextField.text = ""
        abbreviteTextField.text = ""
    }
    
    func showErrorAlert(error:saveError) {
        var errorMsg:String = ""
        
        if error==saveError.City_Nil_Error {
            errorMsg = "Please Input City!"
        }else if error==saveError.NickName_Nil_Error{
            errorMsg = "Please Input NickName!"
        }else if error==saveError.Abbreviate_Nil_Error{
            errorMsg = "Please Input Abbreviation!"
        }
        
        let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: false) { 
            
        }
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

enum saveError:Error {
    case City_Nil_Error
    case NickName_Nil_Error
    case Abbreviate_Nil_Error
}
