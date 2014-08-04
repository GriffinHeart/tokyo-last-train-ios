//
//  ViewController.swift
//  tokyo-last-train-ios
//
//  Created by Hugo Almeida on 8/4/14.
//  Copyright (c) 2014 Hugo Almeida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var   toTextField: UITextField!
    @IBOutlet var resultsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fromChanged(sender: AnyObject) {
        // when writing
    }
    
    @IBAction func toChanged(sender: AnyObject) {
        // when writing
    }
    
    @IBAction func searchPressed(sender: AnyObject) {
        // Do search
        let search = Search(from: fromTextField.text, to: toTextField.text)
        search.perform()
        let theRoute = search.lastRoute
        
        let time = NSDateFormatter().stringFromDate(theRoute!.getTime())
        resultsTextView.text = NSString(format: "Line: %@\nStation: %@\nTime: %@", theRoute!.getLine(), theRoute!.getStation(), theRoute!.getTime())
    }
}



class Search {
    var from: String
    var to: String
    var lastRoute: LastRoute?
    
    init(from: String, to: String){
        self.from = from
        self.to = to
    }
    
    func perform() {
        lastRoute = HyperdiaApi().requestRoute(self.from, to: to)
    }
}

class LastRoute {
    
    func getStation() -> NSString {
        return "omotesando"
    }
    
    func getLine() -> String {
        return "chiyoda-sen"
    }
    
    func getTime() -> NSDate {
        return NSDate()
    }
}

class HyperdiaApi {
    
    func requestRoute(from: String, to: String) -> LastRoute {
        return LastRoute()
    }
}
