//
//  UpdateProfileViewController.swift
//  SampleFullStack
//
//  Created by Rumit Singh Tuteja on 8/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    @IBOutlet weak var txtFieldName:UITextField!
  
    @IBOutlet weak var txtFieldPhoneNo:UITextField!
    @IBOutlet weak var txtFieldAddess:UITextField!
    
    var objUser:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalUISetup()
        
        // Do any additional setup after loading the view.
    }
    func additionalUISetup(){
        txtFieldName.text = objUser.strName!
        txtFieldAddess.text = objUser.strAddress!
        txtFieldPhoneNo.text = objUser.strPhoneNo!
    }

    func validFields() -> Bool{
        if txtFieldName.text != nil && txtFieldAddess.text != nil && txtFieldPhoneNo.text != nil {
            return true
        }
        return false
    }
    
    func updateProfileWithParams(dict:[String:String]){
        if let urlString = URL(string:Services.wsBaseURL + Services.wsUpdateProfile){
            var request = URLRequest(url:urlString)
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
                request.httpBody = jsonData
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue(objUser.strSessionToken!, forHTTPHeaderField:"x-access-token")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error != nil {
                        
                    }else{
                        if data != nil {
                            if let jsonString = try? JSONSerialization.jsonObject(with: data!, options:    []) as! [String:Any] {
                                print(jsonString)
                                self.objUser.strAddress = self.txtFieldAddess.text!
                                self.objUser.strName = self.txtFieldName.text!
                                self.objUser.strPhoneNo = self.txtFieldPhoneNo.text!
                                DispatchQueue.main.async {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                    }
                }
                })
                task.resume()
            }
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if validFields(){
            updateProfileWithParams(dict: ["name":txtFieldName.text!, "address":txtFieldAddess.text!, "phoneNo":txtFieldPhoneNo.text!,"emailID":objUser.strEmailID!])
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
