import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON();
    }
    
    private func parseJSON() {
        guard let path = Bundle.main.path(forResource: "user", ofType: "json") else {
            
            return
        }
        let url = URL(fileURLWithPath: path)
        
        var result: user?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(user.self, from: jsonData)
            
            if let result = result {
                print(result)
                testLabel.text = result.name!
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

struct user: Decodable {
    let name: String?
    let skillLevel: String?
    let avatar: String?

    struct courses: Decodable {
        let courseId: Int?
        let courseName: String?
        let courseProgress: Int?
    }
    let courses: [courses]?

    struct dictionary: Decodable {
        let dictionaryProgress: Int?
    }
    let dictionary: dictionary?
    
    struct quiz: Decodable {
        let quizId: Int?
        let quizName: String?
        let quizProgress: Int?
    }
    let quizes: [quiz]?
}
