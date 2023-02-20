//
//  GameTestCase.swift
//  JeuSetMatchTests
//
//  Created by kev on 2023-02-18.
//  Copyright © 2023 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class GameTestCase: XCTestCase {
    // template string for BDD
    // *test* Given [ X starting/initial state ]
    //        When [ Y action/target ]
    //        Then [ Z results ]
    var game: Game!
    override func setUp() {
        super.setUp()
        game = Game()
    }
    func setPlayerOneScore(_ score: Int) {
        game.scores[.one] = score
    }
    func testGivenScoreIsNull_WhenIncrementingPlayer1Score_ThenScoreShouldBeFifteen() {
        // when
        game.incrementScore(forPlayer: .one)
        // then
        XCTAssert(game.scores[.two]! == 0)
        XCTAssert(game.scores[.one]! == 15)
    }
    func testGivenScoreIsFifteen_WhenIncrementingPlayer1Score_ThenScoreShouldBeThirty() {
        setPlayerOneScore(15)

        game.incrementScore(forPlayer: .one)
        XCTAssert(game.scores[.two]! == 0)
        XCTAssert(game.scores[.one]! == 30)
    }
    func testGivenScoreIsThirty_WhenIncrementingPlayer1Score_ThenScoreShouldBeForty() {
        setPlayerOneScore(30)

        game.incrementScore(forPlayer: .one)
        XCTAssert(game.scores[.two]! == 0)
        XCTAssert(game.scores[.one]! == 40)
    }
    func testGivenScoreIsForty_WhenIncrementingPlayer1Score_ThenPlayer1ShouldWinAndGameIsOver() {
        setPlayerOneScore(40)

        game.incrementScore(forPlayer: .one)

        XCTAssert(game.winner == .one)
        XCTAssertTrue(game.isOver)
    }
}
