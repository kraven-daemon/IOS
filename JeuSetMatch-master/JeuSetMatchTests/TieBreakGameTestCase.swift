//
//  TieBreakGameTestCase.swift
//  JeuSetMatchTests
//
//  Created by kev on 2023-02-19.
//  Copyright © 2023 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class TieBreakGameTestCase: XCTestCase {

    var tieBreakGame: TieBreakGame!
    override func setUp() {
        super.setUp()
        tieBreakGame = TieBreakGame()
    }

    func testGivenScoreIsZero_WhenIncrementingScore_ThenScoreIsOne() {
        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 1)
    }

    func testGivenScoreIs6_WhenIncrementingScore_ThenScoreIs7AndGameIsOver() {
        tieBreakGame.scores[.one] = 6
        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 7)
        XCTAssertTrue(tieBreakGame.isOver)
    }

    func testGivenScoreIs6vs6_WhenIncrementingScore_ThenScoreIs7vs6AndGameIsNotOver() {
        tieBreakGame.scores[.one] = 6
        tieBreakGame.scores[.two] = 6
        tieBreakGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(tieBreakGame.scores[.one], 7)
        XCTAssertEqual(tieBreakGame.scores[.two], 6)
        XCTAssertFalse(tieBreakGame.isOver)
    }
}
