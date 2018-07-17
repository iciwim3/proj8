//
//  ViewController.swift
//  Proj8-7SwiftyWords
//
//  Created by Sain-R Edwards Jr. on 7/15/18.
//  Copyright © 2018 Swift Koding 4 Everyone. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        
        loadLevel()
        
    }

    @objc func letterTapped(btn: UIButton) {
        
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        // Accessing the level file path that was imported
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            // Make sure all of the contents inside the file are strings
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                // Separate each line in the file by the new line / line break
                var lines = levelContents.components(separatedBy: "\n")
                // Randomize the words/lines and storing them in an array
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                // Places the item into the 'line' variable and its position into the 'index' variable
                for (index, line) in lines.enumerated() {
                    // New array constant called 'parts' which is separated by the colon ':'
                    let parts = line.components(separatedBy: ": ")
                    // Designated the answer part (everything to the left of the colon) as a new constant called 'answer'
                    let answer = parts[0]
                    // Everthing to the right of the colon is the 'clue'
                    let clue = parts[1]
                    
                    // Give the clue string a number and assigns the actual clue to it.
                    clueString += "\(index + 1). \(clue)\n"
                    
                    // Removes the pipes '|' from the word and replaces them with empty spaces ("") to make the word whole again
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    // Adds letters from the 'solutionWord' to the 'solutionString'
                    solutionString += "\(solutionWord.count) letters\n"
                    // Adds the 'solutionWord' to the 'solutions' array
                    solutions.append(solutionWord)
                    
                    // Separates the answer parts of each word into separate components by the '|' and stores them in a new array constant called 'bits'
                    let bits = answer.components(separatedBy: "|")
                    // Adds the 'bits' into the 'letterBits' array
                    letterBits += bits
                }
            }
        }
        // Set text to 'cluesLabel' to the 'clueString' while removing the white spaces and lines
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        // Set text to 'answersLabel' to the 'solutionString' while removing the white spaces and lines
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Randmomizing the 'letterBits' so the words are not easily read
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        // Comparing the number of letter bits to number of buttons
        if letterBits.count == letterButtons.count {
            // Count from 0 up to but not including the number of buttons. Can set a button to a letter group. Half open range operator is used.
            for i in 0 ..< letterBits.count {
                // Set the title of the 'letterButton' to the 'letterBit'
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
    @IBAction func clearTapped(_ sender: Any) {
    }
    

}

