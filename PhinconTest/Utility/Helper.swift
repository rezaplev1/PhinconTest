//
//  Helper.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation
import Alamofire

public class Helper {
    
    //MARK : CHECKING IS CONNECTING TO NETWORK
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func fibonacciSeries(num: Int) -> Int{

       // Checking number for num 0 and 1
       // Or we can say it is the base condition for recursive
       // function
       if (num == 0){
          return 0
       }
       else if (num == 1){
          return 1
       }
       // To find the with number we add the previous two numbers
       // Here we find the previous two numbers by calling the function itself and return the result.
       return fibonacciSeries(num: num - 1) + fibonacciSeries(num: num -  2)
    }
}
