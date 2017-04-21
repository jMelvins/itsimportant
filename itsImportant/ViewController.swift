//
//  ViewController.swift
//  itsImportant
//
//  Created by Vladislav Shilov on 17.04.17.
//  Copyright © 2017 Vladislav Shilov. All rights reserved.
//


import UIKit
import BigInt

class ViewController: UIViewController {
    
    struct SearchResult{
        var indexOfNumber : String
        var number : String
    }
    
    let workerQueue = DispatchQueue(label: "com.fib.worker_concurrent", qos: .userInitiated, attributes: .concurrent)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var hasSearch : Bool = false
    var arrayOfNumbers = [SearchResult]()
    var count = 1000000000000000000
    

//    func fibo(){
//        for index in 3...count{
//            var y : BigInt = 1
//            var x : BigInt = 1
//            y = x + y
//            x = y - x
//            arrayOfNumbers.append(SearchResult(indexOfNumber: String(index), number: String(y)))
//            //arrayOfNumbers = [SearchResult(indexOfNumber: String(index), number: String(y))]
//            
//        }
//    }

    func fibo(){
        var a11: BigInt = 1;     var a12 : BigInt = 1
        var a21: BigInt = 1;     var a22 : BigInt = 0
        
        let b11: BigInt = 1;     let b12 : BigInt = 1
        let b21: BigInt = 1;     let b22 : BigInt = 0
        
        var c11: BigInt = 1;     var c12 : BigInt = 1
        var c21: BigInt = 1;     var c22 : BigInt = 0
        
        for index in 3...count{
            
            c11 = b11*a11 + b12*a21
            c12 = b11*a12 + b12*a22
            c21 = b21*a11 + b22*a21
            c22 = b21*a12 + b22*a22
        
            a11 = c11; a12 = c12; a21 = c21; a22 = c22
            
            arrayOfNumbers.append(SearchResult(indexOfNumber: String(index), number: String(a11)))
        }
    }
    
    
    func reload(){
        for _ in 1...count/100{
            tableView.reloadData()
            sleep(3)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        arrayOfNumbers = [
            SearchResult(indexOfNumber: "1", number: "1"),
            SearchResult(indexOfNumber: "2", number: "1")
        ]
        
        workerQueue.async {
            self.fibo()
        }
        
        workerQueue.async {
            self.reload()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController: UISearchBarDelegate {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    
        if !searchBar.text!.isEmpty {
            
            let asd = Int(searchBar.text!)

            if asd == nil{
        
                let alertController = UIAlertController(title: "Not a digital value", message: "You entered not a digital value. Try again.", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if asd! <= 0{
                tableView.scrollToRow(at: [0 , 0], at: .middle, animated: true)
                return
            }
            
            if Int(searchBar.text!)!-1 > arrayOfNumbers.count{
                
                let alertController = UIAlertController(title: "Ooops..", message: "We didnt find this number yet", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                tableView.scrollToRow(at: IndexPath(row: Int(searchBar.text!)!-1,
                                                    section: 0), at: .middle, animated: true)
            }
            
            searchBar.text = ""
            return
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}


extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfNumbers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Title")
        let detailArray = arrayOfNumbers[indexPath.row]
        
        cell.textLabel?.text = detailArray.indexOfNumber
        cell.detailTextLabel?.text = detailArray.number
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailNumbers = arrayOfNumbers[indexPath.row]
        
        let alertController = UIAlertController(title: "\(detailNumbers.indexOfNumber)", message: "Number is: \(detailNumbers.number).", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
