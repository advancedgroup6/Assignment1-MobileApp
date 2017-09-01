//
//  ViewController.swift
//  SampleFullStack
//
//  Created by Rumit Singh Tuteja on 8/30/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldPhoneNo: UITextField!
    @IBOutlet weak var txtFieldEmailID: UITextField!
    @IBOutlet weak var txtFieldAddress: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForSessionInfo()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func checkForSessionInfo(){
        let userDefaults = UserDefaults.standard
        if let dictData = userDefaults.value(forKey: "sessionDetails") as? [String: Any]{
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "profileVC") as! UserProfileViewController
            let objUser = User(params: dictData["userDetails"] as? [String : Any] ?? [:], withToken:dictData["token"] as! String)
            profileVC.user = objUser
            self.navigationController?.pushViewController(profileVC, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func validFields() -> Bool{
        return true
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
//        let dict = ["username":txtFieldName.text, "description": txtFIeldDescription.text, "emailid":txtFieldEmailID.text]
        if validFields(){
            let dict = ["name":txtFieldName.text!,
                        "emailID":txtFieldEmailID.text!,
                        "phoneNo":txtFieldPhoneNo.text!,
                        "address" :txtFieldAddress.text!,
                        "password":txtFieldPassword.text!]
            sendLoginRequest(dictParams: dict)
        }
    }
    
    func prepareSessionForUser(jsonString:[String:Any]){
        let defaults = UserDefaults.standard
        defaults.set(jsonString, forKey: "sessionInfo")
    }
    
    func sendLoginRequest(dictParams:[String:String]){
        if let urlString = URL(string: Services.wsBaseURL + Services.wsSignUP){
            var request = URLRequest(url: urlString)
            let jsonData = try? JSONSerialization.data(withJSONObject: dictParams, options: .prettyPrinted)
            if let json = jsonData {
                request.httpMethod = "POST"
                request.httpBody = json
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error getting data")
                    }else{
                        if data != nil {
                            if let jsonString = try? JSONSerialization.jsonObject(with: data!, options:    []) as! [String:Any] {
                                let status = jsonString["status"] as! String
                                if status == "200" {
                                    print(jsonString)
                                    let objUser = User(params: jsonString["userDetails"] as? [String : Any] ?? [:], withToken:jsonString["token"] as! String)
                                    let storyboard = UIStoryboard(name: "Main", bundle:nil)
                                    let profileVC = storyboard.instantiateViewController(withIdentifier: "profileVC") as! UserProfileViewController
                                    profileVC.user = objUser
                                    self.prepareSessionForUser(jsonString: jsonString)
                                    DispatchQueue.main.async {
                                        self.navigationController?.pushViewController(profileVC, animated: true)
                                    }
                                }
                            }else{
                                print("no printable data")
                            }
                        }
                    }
                })
                task.resume()
            }
        }
        
        

        
        //        do {
//        }catch let error {
//            print(error.localizedDescription)
//        }
    }
}

