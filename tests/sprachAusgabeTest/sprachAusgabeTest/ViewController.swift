//
//  ViewController.swift
//  sprachAusgabeTest
//
//  Created by Neidhart Manuel on 11.03.22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var welcherText: UITextField!
    
    var utterance : AVSpeechUtterance!
    
    @IBOutlet weak var Slider: UISlider!
    
    @IBAction func pitch(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.utterance.pitchMultiplier = Float(currentValue)
        print(currentValue)
    }
    
    @IBAction func speechButton(_ sender: Any) {
        self.utterance =  AVSpeechUtterance(string: welcherText.text!)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(self.utterance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.utterance =  AVSpeechUtterance(string: "")
        self.utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        self.utterance.rate = 300.0
    }
}

