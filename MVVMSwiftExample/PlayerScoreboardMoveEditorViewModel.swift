//
//  PlayerScoreboardMoveEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Mathieu Janneau on 28/08/2018.
//  Copyright © 2018 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardMoveEditorViewModel {
  var playerName: String { get }
  
  var onePointMoveCount: Dynamics<String> { get }
  var twoPointMoveCount: Dynamics<String> { get }
  var assistMoveCount: Dynamics<String> { get }
  var reboundMoveCount: Dynamics<String> { get }
  var foulMoveCount: Dynamics<String> { get }
  
  func onePointMove()
  func twoPointsMove()
  func assistMove()
  func reboundMove()
  func foulMove()
}
