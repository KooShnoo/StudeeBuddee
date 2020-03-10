//
//  ViewController.swift
//  M-A Studee Buddee
//
//  Created by Ishan Chawla on 7/10/19.
//  Copyright © 2019 Ishan Chawla. All rights reserved.
//

import UIKit
import WebKit
import YoutubePlayer_in_WKWebView

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var titleLabel: UILabel!    
    @IBOutlet weak var videoYT: WKYTPlayerView!
    @IBOutlet weak var picker: UIPickerView!
    
    var videoID = "-Xaq103pD4E"
    var selectedItem: [Int] = [0,0]
    var userChoices: [[String]] = []
    var lessons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var problems: [String] = []
    let courses = [["AS Algebra II", "Geometry Enriched"]]
    var chaptersLessons = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]]
    var pickerData = [["AS Algebra II", "Geometry Enriched"]]
    var currentScreen = "Course"
    
    
    func reloadChapterLessonPicker() {
        chaptersLessons = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], lessons]
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func addUserChoice() {
        print("\(pickerData[selectedItem[0]]), \(userChoices), \([selectedItem[1]])")
        userChoices.append(["\(selectedItem[0])", pickerData[selectedItem[0]][selectedItem[1]]])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // make second picker's content depend on the first
        selectedItem = [component, row]
        if component == 0 && currentScreen == "Chapter & Lesson"{
            switch row{
            case 0:
                lessons = ["1", "2", "3", "4", "5", "6"]
            case 1:
                lessons = ["1", "2", "3", "4", "5", "6"]
            case 2:
                lessons = ["1", "2", "3", "4", "5"]
            case 3:
                lessons = ["1", "2", "3", "4", "5", "6"]
            case 4:
                lessons = ["1", "2", "3", "4", "5", "6", "7", "8"]
            case 5:
                lessons = ["1", "2", "3", "4", "5", "6"]
            case 6:
                lessons = ["1", "2", "3", "4", "5"]
            case 7:
                lessons = ["1", "2", "3", "4", "5"]
            case 8:
                lessons = ["1", "2", "3", "4", "5", "6", "7"]
            case 9:
                lessons = ["1", "2", "3", "4", "5", "6", "7"]
            case 10:
                lessons = ["1", "2", "3", "4", "5", "6", "7", "8"]
            case 11:
                lessons = ["1", "2", "3", "4", "5", "6"]
            default:
                print("error!! '\(row)' not recognized")
            }
            chaptersLessons = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], lessons]
            pickerData = chaptersLessons
            reloadChapterLessonPicker()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Load pickerData into the picker
        return pickerData[component][row]
    }
    @IBAction func backClick(_ sender: Any) {
        userChoices.removeLast()
        switch currentScreen{
        case "Chapter & Lesson":
            changeScreen(screen: "Course")
        case "Problem":
            changeScreen(screen: "Chapter & Lesson")
        case "Resources":
            changeScreen(screen: "Problem")
        default:
            print("error!! back button")
        }
    }
    @IBAction func nextClick(_ sender: Any) {
        addUserChoice()
        switch currentScreen {
        case "Course":
            changeScreen(screen: "Chapter & Lesson")
        case "Chapter & Lesson":
            changeScreen(screen: "Problem")
        case "Problem":
            changeScreen(screen: "Resources")
        default:
                print("error!! next button")
        }
    }
    
    func changeScreen(screen: String) {
        switch screen {
        case "Chapter & Lesson":
            currentScreen = "Chapter & Lesson"
            videoYT.isHidden = true
            backButton.isHidden = false
            nextButton.isHidden = false
            picker.isHidden = false
            self.titleLabel.text = "Chapter & Lesson"
            lessons = ["1", "2", "3", "4", "5", "6"]
            chaptersLessons = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], lessons]
            pickerData = chaptersLessons
            reloadChapterLessonPicker()
        case "Course":
            currentScreen = "Course"
            videoYT.isHidden = true
            backButton.isHidden = true
            nextButton.isHidden = false
            picker.isHidden = false
            self.titleLabel.text = "Course"
            pickerData = courses
            reloadChapterLessonPicker()
        case "Problem":
            currentScreen = "Problem"
            videoYT.isHidden = true
            backButton.isHidden = false
            nextButton.isHidden = false
            picker.isHidden = false
            self.titleLabel.text = "Problem"
            pickerData = [problems]
            reloadChapterLessonPicker()
        case "Resources":
            videoID = "xsm1x6dCej4"
            currentScreen = "Resources"
            videoYT.isHidden = false
            backButton.isHidden = false
            nextButton.isHidden = true
            picker.isHidden = true
            self.titleLabel.text = "Resources"
        default:
            print("error!! '\(screen)' not recognized")
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        videoYT.load(withVideoId: videoID)
        let arr1 = Array(1...74)
        problems = arr1.map { String($0) }
        nextButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        reloadChapterLessonPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

