//
//  ViewController.swift
//  HouNetwork
//
//  Created by jerome.developer.tw@gmail.com on 11/08/2019.
//  Copyright (c) 2019 jerome.developer.tw@gmail.com. All rights reserved.
//

import UIKit
import HouNetwork

class ViewController: UIViewController {
  
  lazy var queue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "networkQueue"
    queue.maxConcurrentOperationCount = 4
    queue.qualityOfService = QualityOfService.userInitiated
    return queue
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    let request = APIRequest(url: url)
    let operation = NetworkRequestOperation(request: request) { result in
//      {
//        "userId": 1,
//      }
      
      switch result {
      case let .success(response):
        if let data = response.body {
          do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
              fatalError()
            }

            guard let userId = json["userId"] as? Int else {
              fatalError()
            }
            print("Success!userId: \(userId)")
          } catch {
            fatalError()
          }
        } else {
          fatalError()
        }
        
      case let .failure(error):
        fatalError()
      }
    }
    queue.addOperation(operation)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

