//
//  MatchTestCase.swift
//  JeuSetMatchTests
//
//  Created by kev on 2023-02-18.
//  Copyright © 2023 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class MatchTestCase: XCTestCase {
    var match: Match!
    override func setUp() {
        super.setUp()
        match = Match()
    }
    // games into set
    func createGames(_ winner: Player, _ amount: Int, _ set: Set) {
        for _ in 1...amount {
            let game = Game()
            game.winner = winner
            set.games.append(game)
        }
    }
    // sets into match
    func createSets(_ player: Player, _ amount: Int) {
        for _ in 1...amount {
            let set = Set()
            createGames(player, 6, set)
            match.sets.append(set)
        }
    }
    // match over
    func testGivenPlayer1Has3Wins_WhenGettingWinner_ThenWinnerShouldBePlayer1AndMatchIsOver() {
        createSets(.one, 3)

        XCTAssertEqual(match.winner, .one)
        XCTAssertTrue(match.isOver)
    }
    // game over
    func testGivenPlayer1Has40InGame_WhenAddingPoint_ThenPlayer1ShouldHaveWon1Games() {
        match.currentGame.scores[.one] = 40
        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.last!.games.first!.isOver)
        XCTAssertEqual(match.sets.last?.games.count, 2)
    }
    // set over
    func testGivenPlayer1HasScore40InLastGame_WhenAddingAScore_ThenAddNewSetAndGameIsOver() {
        createGames(.one, 5, match.sets.last!)
        match.sets.last?.games.append(Game())
        match.currentGame.scores[.one] = 40

        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.first!.games.last!.isOver)
        XCTAssertEqual(match.sets.count, 2)
    }
    func testGivenCurrentGameScoreIs40AndSetScoreIs6vs6_WhenPointIsAdded_ThenTieBreakGameIsCreated() {
        createGames(.one, 5, match.sets.last!)
        createGames(.two, 6, match.sets.last!)
        match.sets.last?.games.append(Game())
        match.currentGame.scores[.one] = 40

        match.pointEnded(wonBy: .one)

        XCTAssert(match.currentGame is TieBreakGame)
    }
}
