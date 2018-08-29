//
//  Dynamics.swift
//  MVVMSwiftExample
//
//  Created by Mathieu Janneau on 28/08/2018.
//  Copyright © 2018 Toptal. All rights reserved.
//

import Foundation

class Dynamics<T> {
  typealias Listener = (T) -> Void
  var listener : Listener?
  
  func bind(listener: Listener?) {
    self.listener = listener
     listener?(value)
  }
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ v: T) {
    self.value = v
  }
}
