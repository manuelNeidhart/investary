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
        
        self.getCourseData() { (courses) -> () in
            DispatchQueue.main.async {
                print(courses.courseElements!)
                self.courseText.text = courses.courseElements![0].description?.description
                self.wordNameLabel.text = courses.courseElements![0].wordName?.description
                self.utterance = AVSpeechUtterance(string: courses.courseElements![0].description?.description ?? "nix da")
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


