//
//  ViewController.swift
//  tokyo-last-train-ios
//
//  Created by Hugo Almeida on 8/4/14.
//  Copyright (c) 2014 Hugo Almeida. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  
  @IBOutlet var   fromTextField: MLPAutoCompleteTextField!
  @IBOutlet var     toTextField: MLPAutoCompleteTextField!
  @IBOutlet var resultsTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dataSrc = StationsDataSource()

    dataSrc.loadStations()
    fromTextField.autoCompleteDataSource = dataSrc
    toTextField.autoCompleteDataSource = dataSrc
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction
  func fromChanged(sender: AnyObject) {
    // when writing
  }
  
  @IBAction
  func toChanged(sender: AnyObject) {
    // when writing
  }
  
  @IBAction
  func searchPressed(sender: AnyObject) {
    search()
  }
  
  func search() {
    // Do search
    let search = Search(from: fromTextField.text, to: toTextField.text)
    search.perform()
    let theRoute = search.lastRoute
    
    let time = NSDateFormatter().stringFromDate(theRoute!.getTime())
    resultsTextView.text = NSString(
      format: "Line: %@\nStation: %@\nTime: %@",
      theRoute!.getLine(), theRoute!.getStation(), theRoute!.getTime()
    )
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
    lastRoute = HyperdiaApi().requestRoute(from, to: to)
  }
}

class LastRoute {
  
  func getStation() -> NSString {
    return "omotesando"
  }
  
  func getLine() -> NSString {
    return "chiyoda-sen"
  }
  
  func getTime() -> NSDate {
    return NSDate()
  }
}

class HyperdiaApi {
  let urlFormat = "http://www.hyperdia.com/cgi/search/smartphone/android_free/en/hyperdia2.cgi?search_target=route" +
  "&dep_node=%s&arv_node=%s&via_node01=&via_node02=&via_node03=&year=%s&month=%s&day=%s&hour=%s&minute=%s" +
  "&search_type=lasttrain&search_way=time&sort=time&max_route=1&sum_target=7"
  
  func requestRoute(from: String, to: String) -> LastRoute {

    //figure time and date
    let currentDate = NSDateComponents()
    let midNightDate = NSDateComponents()
    
    currentDate.setValue(3, forKey: "day")
    let x = currentDate.day
    return LastRoute()
  }
  
  
}

class StationsDataSource: NSObject, MLPAutoCompleteTextFieldDataSource {
  let filePath = "stations_all.json"
  var stations:[String] = []
  
  func loadStations() {
    stations = ["SHIBUYA", "ROPPONGI"]
  }
  
  func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!) -> [AnyObject]! {
    return stations.filter { $0.hasPrefix(string) }
  }
  
  func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!, completionHandler handler: (([AnyObject]!) -> Void)!)  {
    
    let matchingStations = stations.filter { $0.hasPrefix(string) }
    handler(matchingStations)
  }
}