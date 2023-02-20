//
//  SetTestCase.swift
//  JeuSetMatchTests
//
//  Created by kev on 2023-02-18.
//  Copyright © 2023 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class SetTestCase: XCTestCase {
    /*
    internal var games: <<error type>>
    internal var winner: Player? { get }
    internal var isOver: Bool { get }
    internal var scores: [Player : Int] { get }
    internal static let maxNumberOfWonGames: Int
     
     test set behavior
     test winning behavior
    */
    var set = Set()
    override func setUp() {
        super.setUp()
        set = Set()
    }
    func setWinningGamePerPlayer(_ player: Player, _ wins: Int) {
        for _ in 1...wins {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
    }
    func testGivenPlayer1HasOneAndPlayer2HasTwo_WhenGettingScore_ThenScoreShouldBe1and2() {
        setWinningGamePerPlayer(.one, 1)
        setWinningGamePerPlayer(.two, 2)

        XCTAssertEqual(set.scores[.one], 1)
        XCTAssert(set.scores[.two] == 2)
    }
    func testGivenGameIsNotOver_WhenGettingWinner_ThenWinnerShouldBeNil() {
        setWinningGamePerPlayer(.one, 5)
        setWinningGamePerPlayer(.two, 5)

        XCTAssertEqual(set.scores[.one], 5)
        XCTAssertEqual(set.scores[.two], 5)
        XCTAssertFalse(set.isOver)
        XCTAssertNil(set.winner)
    }
    func testGivenPlayer1Has6Wins_WhenGettingWinnerAndGettingSet_ThenWinnerShouldBePlayer1AndSetShouldBeOver() {
        setWinningGamePerPlayer(.one, 6)

        XCTAssertEqual(set.scores[.one], 6)
        XCTAssertTrue(set.isOver)
        XCTAssertEqual(set.winner, .one)
    }

    func testGivenScoresIs6vs5_WhenGettingWinner_ThenNoWinnerAndSetIsNotOver() {
        setWinningGamePerPlayer(.one, 6)
        setWinningGamePerPlayer(.two, 5)

        XCTAssertNil(set.winner)
        XCTAssertFalse(set.isOver)
    }
    func testGivenScoreIs7vs6_WhenGettingWinner_ThenPlayer1IsWinner() {
        setWinningGamePerPlayer(.one, 7)
        setWinningGamePerPlayer(.two, 6)

        XCTAssertEqual(set.winner!, .one)
        XCTAssertTrue(set.isOver)
    }
}
