//
//  DetailViewController.swift
//  NCMBMemo
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD

class DetailViewController: UIViewController {
    var selectedMemo:NCMBObject!

    @IBOutlet weak var memoTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        memoTextView.text = selectedMemo.object(forKey: "memo") as! String
    }
    
    @IBAction func update(_ sender: Any) {
        //保存
        selectedMemo.setObject(memoTextView.text, forKey: "memo")
        selectedMemo.saveInBackground { (error) in
            if error != nil{
//                print(error)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }else{
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        selectedMemo.deleteInBackground { (error) in
            if error != nil{
                 SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }else{
                //削除成功
               self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
   
}
