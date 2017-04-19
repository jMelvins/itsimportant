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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var hasSearch : Bool = false
    
    var arrayOfNumbers = [SearchResult]()
    
    func fibo(){
        var y : BigInt = 1
        var x : BigInt = 1
        
        for index in 3...2000{
            y = x + y
            x = y - x
            arrayOfNumbers.append(SearchResult(indexOfNumber: String(index), number: String(y)))
            //arrayOfNumbers = [SearchResult(indexOfNumber: String(index), number: String(y))]
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
        
        fibo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        hasSearch = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hasSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hasSearch = false
    }
    
    
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
            
            if Int(searchBar.text!)! > arrayOfNumbers.count{
                
                let alertController = UIAlertController(title: "Ooops..", message: "Something went wrong. We couldn't find this number", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                tableView.scrollToRow(at: IndexPath(row: Int(searchBar.text!)!-1,
                                                    section: 0), at: .middle, animated: true)
            }
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
