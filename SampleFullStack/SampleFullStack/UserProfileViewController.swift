//
//  UserProfileViewController.swift
//  SampleFullStack
//
//  Created by Rumit Singh Tuteja on 8/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailID: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalUISetup()
        // Do any additional setup after loading the view.
    }

    func additionalUISetup(){
        lblName.text = user?.strName
        lblEmailID.text = user?.strEmailID
        lblAddress.text = user?.strAddress
        lblPhoneNo.text = user?.strPhoneNo
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
