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
    var courseCount: Int!
    var lengthOfCourses: Int!
    var level: Int! = 0
    
    @IBAction func continueButton(_ sender: Any){
        if coursePartCounter == 1 {
            continueButtonText.setTitle("finish", for: .normal)
        }else if coursePartCounter >= 2{
            coursePartCounter = 0
            updateCourse()
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "finishSegue", sender: self)
            }
            
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
        self.navigationItem.hidesBackButton = true
        
        DispatchQueue.main.async {
            
            self.loadData()
        }
    }
    
    func getCourseProgress(completionHandler: @escaping((_ courseData: Int)->())){
        guard let url = URL(string: "http://localhost:8000/courseProgress/\(level!.description)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                var courseData = try decoder.decode(Int.self, from: data)
                completionHandler(courseData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func resetData() {
        guard let url = URL(string: "http://localhost:8000/resetCourse/\(level!)") else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
            
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        if (httpResponse.statusCode != 200) {
                            return
                        }
                    }
                    
                }
                task.resume()
            }

    
    func loadData(){
        
        self.getCourseData() { (courses) -> () in
            DispatchQueue.main.async {
                self.lengthOfCourses = courses.courseElements?.count
            }
        }
        
 
        
            self.getCourseProgress(completionHandler: { courseData in
                DispatchQueue.main.async {
                
                
                self.courseCount = Int(courseData)
                
                //print("Course Count: " + String(self.courseCount))
                
                
                if(self.courseCount >= self.lengthOfCourses ){
                    self.level = 1
                    
                    
                   self.resetData()
                    self.courseCount = 0
                   // print("Course Count Reset: " + String(self.courseCount))
            
                }
            
              //  print("Length Of Courses: " + String(self.lengthOfCourses))
              
                    self.getCourseData() { (courses) -> () in
                        DispatchQueue.main.async {
                        //    print("Queue Course Count: " + String(self.courseCount))
                           
                            self.courseText.text = courses.courseElements![self.courseCount!].description[self.coursePartCounter!].description
                            self.wordNameLabel.text = courses.courseElements![self.courseCount!].wordName?.description
                            self.utterance = AVSpeechUtterance(string: courses.courseElements![self.courseCount!].description[0].description)
                            self.utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                            self.utterance.rate = 0.1
                            let synthesizer = AVSpeechSynthesizer()
                            synthesizer.speak(self.utterance)
                        }
                    }
                }
                })
         
     
        
        
        }
    
    func updateCourse() {
        guard let url = URL(string: "http://localhost:8000/profile/\(level!.description)") else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
            
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        if (httpResponse.statusCode != 200) {
                            return
                        }
                    }
                    
                }
                task.resume()
            }
    
    func getCourseData(completionHandler: @escaping((_ courseData: course)->())){
        guard let url = URL(string: "http://localhost:8000/course/\(level!.description)") else {return}
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


