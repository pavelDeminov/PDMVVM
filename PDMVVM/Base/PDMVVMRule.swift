//
//  PDMVVMRule.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 02/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

public enum PDMVVMValidationState : Int {
    case none
    case valid
    case invalid
}

public typealias PDMVVMValidationBlock = (Any?, String?) -> Bool

public class PDMVVMRule: NSObject {

    var validationBlock: PDMVVMValidationBlock?
    var error = ""
    var state: PDMVVMValidationState?
    
    func validate(_ value: Any?) {
        if let validationBlock = validationBlock {
            state = validationBlock(value, error) ? .valid : .invalid
        }
    }
    
    func invalidate() {
        state = Optional.none
    }
    
}
