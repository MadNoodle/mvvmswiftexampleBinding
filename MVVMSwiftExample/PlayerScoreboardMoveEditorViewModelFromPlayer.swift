//
//  PlayerScoreboardMoveEditorViewModelFromPlayer.swift
//  MVVMSwiftExample
//
//  Created by Mathieu Janneau on 28/08/2018.
//  Copyright © 2018 Toptal. All rights reserved.
//

import Foundation

class PlayerScoreboardMoveEditorViewModelFromPlayer: NSObject, PlayerScoreboardMoveEditorViewModel {
  
  fileprivate let player: Player
  fileprivate let game: Game
  
  var playerName: String
  var onePointMoveCount: Dynamics<String>
  var twoPointMoveCount: Dynamics<String>
  var assistMoveCount: Dynamics<String>
  var reboundMoveCount: Dynamics<String>
  var foulMoveCount: Dynamics<String>
  
  func onePointMove() {
    makeMove(.onePoint)
  }
  
  func twoPointsMove() {
    makeMove(.twoPoints)
  }
  
  func assistMove() {
    makeMove(.assist)
  }
  
  func reboundMove() {
    makeMove(.rebound)
  }
  
  func foulMove() {
    makeMove(.foul)
  }
  
  // MARK: Init
  
  init(withGame game: Game, player: Player) {
    self.game = game
    self.player = player
    
    self.playerName = player.name
    self.onePointMoveCount = Dynamics("\(game.playerMoveCount(for: player, move: .onePoint))")
    self.twoPointMoveCount = Dynamics("\(game.playerMoveCount(for: player, move: .twoPoints))")
    self.assistMoveCount = Dynamics("\(game.playerMoveCount(for: player, move: .assist))")
    self.reboundMoveCount = Dynamics("\(game.playerMoveCount(for: player, move: .rebound))")
    self.foulMoveCount = Dynamics("\(game.playerMoveCount(for: player, move: .foul))")
  }
  
  // MARK: Private
  
  fileprivate func makeMove(_ move: PlayerInGameMove) {
    game.addPlayerMove(move, for: player)
    
    onePointMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
    twoPointMoveCount.value = "\(game.playerMoveCount(for: player, move: .twoPoints))"
    assistMoveCount.value = "\(game.playerMoveCount(for: player, move: .assist))"
    reboundMoveCount.value = "\(game.playerMoveCount(for: player, move: .rebound))"
    foulMoveCount.value = "\(game.playerMoveCount(for: player, move: .foul))"
  }
  
  
}
