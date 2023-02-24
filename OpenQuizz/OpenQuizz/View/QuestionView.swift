//
//  QuestionView.swift
//  OpenQuizz
//
//  Created by kev on 2023-02-19.
//

import UIKit

class QuestionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet private var label: UILabel!
    @IBOutlet private var icon: UIImageView!
    enum Style {
        case standard, correct, incorrect
    }
    
    var style: Style = .standard {
        didSet {
            setStyle(style)
        }
    }
    private func setStyle(_ style: Style){
        switch style {
        case .correct:
            self.backgroundColor = UIColor(red: 199 , green: 233, blue: 160, alpha: 1)
            icon.image = UIImage(named: "Icon Correct")
            icon.isHidden = false
        case .incorrect:
            backgroundColor = UIColor(red: 245.0, green: 139.0, blue: 148.0, alpha: 1)
            icon.image = UIImage(named: "Icon Error")
            icon.isHidden = false
        case .standard:
            backgroundColor = UIColor(red: 191.0, green: 196.0, blue: 201.0, alpha: 1)
            icon.isHidden = true
        }
    }
    
    var title = "" {
        didSet {
            label.text = title
        }
    }


}
