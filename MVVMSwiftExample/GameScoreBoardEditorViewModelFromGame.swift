//
//  GameScoreBoardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by Mathieu Janneau on 28/08/2018.
//  Copyright © 2018 Toptal. All rights reserved.
//

import Foundation

class GameScoreBoardEditorViewModelFromGame:NSObject, GameScoreBoardEditorViewModel {
  
  let game: Game
  
  struct Formatter {
    static let durationFormatter: DateComponentsFormatter = {
      let dateFormatter = DateComponentsFormatter()
      dateFormatter.unitsStyle = .positional
      return dateFormatter
    }()
  }
  
  var homeTeam: String
  
  var awayTeam: String
  
  let homePlayers: [PlayerScoreboardMoveEditorViewModel]
  
  let awayPlayers: [PlayerScoreboardMoveEditorViewModel]
  
  var time: Dynamics<String>
  
  var score: Dynamics<String>
  
  var isFinished: Dynamics<Bool>
  
  var isPaused: Dynamics<Bool>
  
  func togglePause() {
    if isPaused.value {
      startTimer()
    } else {
      pauseTimer()
    }
    self.isPaused.value = !isPaused.value
  }
  
  // MARK: - Init
  init(from game: Game) {
    self.game = game
    
    self.homeTeam = game.homeTeam.name
    
    self.awayTeam = game.awayTeam.name
    
    self.homePlayers = GameScoreBoardEditorViewModelFromGame.playerViewModels(from: game.homeTeam.players, game: game)
    self.awayPlayers = GameScoreBoardEditorViewModelFromGame.playerViewModels(from: game.awayTeam.players, game: game)
    self.time = Dynamics(GameScoreBoardEditorViewModelFromGame.timeRemainingPretty(for: game))
   self.score = Dynamics( GameScoreBoardEditorViewModelFromGame.scorePretty(for: game))
    
    self.isFinished = Dynamics(game.isFinished)
    
    self.isPaused = Dynamics(true)
    
    super.init()
    subscribeToNotifications()
  }
  
  deinit {
    unsubscribeFromNotifications()
  }
  
  // MARK: Notifications (Private)
  
  fileprivate func subscribeToNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(gameScoreDidChangeNotification(_:)),
                                           name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification),
                                           object: game)
  }
  
  fileprivate func unsubscribeFromNotifications() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc fileprivate func gameScoreDidChangeNotification(_ notification: NSNotification){
    self.score.value = GameScoreBoardEditorViewModelFromGame.scorePretty(for: game)
    
    if game.isFinished {
      self.isFinished.value = true
    }
  }
  fileprivate static func playerViewModels(from players: [Player], game: Game) -> [PlayerScoreboardMoveEditorViewModel] {
    var playerViewModels: [PlayerScoreboardMoveEditorViewModel] = [PlayerScoreboardMoveEditorViewModel]()
    for player in players {
      playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
    }
    
    return playerViewModels
  }
  
  // MARK: - Private
  
  fileprivate var gameTimer: Timer?
  fileprivate func startTimer() {
    let interval: TimeInterval = 0.001
    gameTimer = Timer.schedule(repeatInterval: interval) { timer in
      self.game.time += interval
      self.time.value = GameScoreBoardEditorViewModelFromGame.timeRemainingPretty(for: self.game)
    }
  }
  
  // MARK: String utils
  
  fileprivate func pauseTimer() {
    gameTimer?.invalidate()
    gameTimer = nil
  }
  
  fileprivate static func timeFormatted(totalMillis: Int) -> String {
    let millis: Int = totalMillis % 1000 / 100 // "/ 100" <- because we want only 1 digit
    let totalSeconds: Int = totalMillis / 1000
    
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60)
    
    return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    
  }
  fileprivate static func timeRemainingPretty(for game: Game) -> String {
    return timeFormatted(totalMillis: Int(game.time * 1000))
  }
  
  fileprivate static func scorePretty(for game: Game) -> String {
    return String(format: "\(game.homeTeamScore) - \(game.awayTeamScore)")
  }
  
  
}
