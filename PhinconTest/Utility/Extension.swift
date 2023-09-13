//
//  Extension.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}


private let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
extension UITableView {
    func spinnerFooter(start : Bool){
        myActivityIndicator.frame = CGRect(x:0, y:0, width:self.frame.width, height:50)
        myActivityIndicator.color = UIColor.gray
        myActivityIndicator.hidesWhenStopped = true
        
        self.tableFooterView = myActivityIndicator
        
        if start {
            myActivityIndicator.startAnimating()
        }else{
            myActivityIndicator.frame = CGRect(x:0, y:0, width:self.frame.width, height:0)
            myActivityIndicator.stopAnimating()
            
        }
    }
}
