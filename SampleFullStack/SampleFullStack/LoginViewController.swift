//
//  LoginViewController.swift
//  SampleFullStack
//
//  Created by Rumit Singh Tuteja on 8/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFieldEmailID: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func validFields() -> Bool{
        return true
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if validFields() {
            createSesisonWithDetails(params: ["emailID":txtFieldEmailID.text!,"password":txtFieldPassword.text!])
        }
    }
    
    func createSesisonWithDetails(params:[String:String]){
        if let urlString = URL(string: Services.wsBaseURL + Services.wsLogin){
            var request = URLRequest(url: urlString)
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            if let json = jsonData{
                request.httpBody = json
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let session = URLSession.shared
                let task = session.dataTask(with:request, completionHandler: {(data, response, error)in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error in login")
                    }else{
                        if data != nil {
                            if let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]{
                                print(jsonResponse)
                            }
                        }
                    }
                })
                task.resume()
            }
        }
    }
    
    func prepareSessionForUser(){
        
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
