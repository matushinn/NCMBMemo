//
//  AddMemoViewController.swift
//  NCMBMemo
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class AddMemoViewController: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //勝手に点滅される
        memoTextView.becomeFirstResponder()
    }

    @IBAction func save(_ sender: Any) {
        let object = NCMBObject(className: "Memo")
        object?.setObject(memoTextView.text, forKey: "memo")
        object?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                let alertController=UIAlertController(title: "保存完了", message: "メモの保存が完了しました。メモ一覧に戻ります。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(action)
                self.present(alertController,animated: true,completion: nil)
        }
        })
    }
    

}
