//
//  GameScoreBoardViewModel.swift
//  MVVMSwiftExample
//
//  Created by Mathieu Janneau on 28/08/2018.
//  Copyright © 2018 Toptal. All rights reserved.
//

import Foundation

protocol GameScoreBoardEditorViewModel {
  
  var homeTeam: String { get}
  var awayTeam: String { get}
  var homePlayers: [PlayerScoreboardMoveEditorViewModel] { get }
  var awayPlayers: [PlayerScoreboardMoveEditorViewModel] { get }
  var time: Dynamics<String> { get }
  var score: Dynamics<String> { get }
  var isFinished: Dynamics<Bool> { get}
  var isPaused: Dynamics<Bool> { get}
  
  func togglePause()
  
}


