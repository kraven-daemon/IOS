//
//  Question.swift
//  OpenQuizz
//
//  Created by kev on 2023-02-19.
//

import UIKit

struct Question {
    var title : String = ""
    var isCorrect : Bool = false
    
    mutating func setTitle(title: String){
        self.title = title
    }
}
