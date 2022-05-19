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
    
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var courseText: UITextView!
    @IBAction func listenButton(_ sender: Any) {
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON() { (courses) -> () in
            print(courses.courseElements!)
            self.courseText.text = courses.courseElements![0].description?.description
            self.wordNameLabel.text = courses.courseElements![0].wordName?.description
            self.utterance = AVSpeechUtterance(string: courses.courseElements![0].description?.description ?? "nix da")
        }
        
   
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.1

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func parseJSON(completionHandler: @escaping ((_ courses: course)->())) {
        guard let path = Bundle.main.path(forResource: "./json/course", ofType: "json") else {
            
            return
        }
        let url = URL(fileURLWithPath: path)
        
        var result: course?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(course.self, from: jsonData)
            print(jsonData)
            print(result)
            if let result = result {
                print(result)
                completionHandler(result)
            }
            else {
                print("Failed to parse")
            }
        }
        catch {
            print("Error: \(error)")
        }
        
    }
}

struct course: Decodable {
    let courseName: String?
    let courseId: Int?

    struct courseElements: Decodable {
        let wordName: String?
        let wordId: Int?
        let isWordFinished: Bool?
        let description: String?
    }
    let courseElements: [courseElements]?
}


