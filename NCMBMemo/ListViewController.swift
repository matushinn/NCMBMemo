//
//  ListViewController.swift
//  NCMBMemo
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class ListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var memoArray = [NCMBObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = memoArray[indexPath.row].object(forKey: "memo") as? String
        return cell!
    }
    

    @IBOutlet weak var memoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        memoTableView.dataSource = self
        memoTableView.delegate = self
        
        //使ってないセルは消す
        memoTableView.tableFooterView = UIView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //押した後解除される
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面の取得
        if segue.identifier == "toDetail"{
            let detailViewController = segue.destination as! DetailViewController
            let selectedIndex = memoTableView.indexPathForSelectedRow!
            detailViewController.selectedMemo = memoArray[selectedIndex.row]
            
            
        }
    }
    func loadData(){
        let query = NCMBQuery(className: "Memo")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }else{
                self.memoArray = result as! [NCMBObject]
                self.memoTableView.reloadData()
            }
        })
    }
    

  

}
