//
//  CourseViewController.swift
//  investary
//
//  Created by Reinhart Robin on 01.04.22.
//

import UIKit
import AVFoundation

class CourseViewController: UIViewController {
    
    var utterance : AVSpeechUtterance!
    var coursePartCounter: Int! = 0
    
    @IBAction func continueButton(_ sender: Any){
        print("continueButton pressed")
        print(coursePartCounter.description)
        
        if coursePartCounter == 2 {
            continueButtonText.setTitle("finish", for: .normal)
        }else if coursePartCounter >= 3{
            coursePartCounter = 0
            
        }
        coursePartCounter = coursePartCounter + 1
        loadData()
    }
    
    @IBOutlet weak var continueButtonText: RoundedButton!
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var courseText: UITextView!
    @IBAction func listenButton(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        print("loadData")
        self.getCourseData() { (courses) -> () in
            DispatchQueue.main.async {
                self.courseText.text = courses.courseElements![0].description[self.coursePartCounter!].description
                self.wordNameLabel.text = courses.courseElements![0].wordName?.description
                self.utterance = AVSpeechUtterance(string: courses.courseElements![0].description[0].description)
                self.utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                self.utterance.rate = 0.1
                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(self.utterance)
            }
        }
    }
    
    func getCourseData(completionHandler: @escaping((_ courseData: course)->())){
        guard let url = URL(string: "http://localhost:8000/course") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                var courseData = try decoder.decode(course.self, from: data)
                completionHandler(courseData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct course: Decodable {
    let courseName: String?
    let courseId: Int?
    
    struct courseElements: Decodable {
        let wordName: String?
        let wordId: Int?
        let isWordFinished: Bool?
        let description: [String]
    }
    let courseElements: [courseElements]?
}


