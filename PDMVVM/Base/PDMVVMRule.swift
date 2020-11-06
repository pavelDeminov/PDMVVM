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

open class PDMVVMRule: NSObject {

    public var validationBlock: PDMVVMValidationBlock?
    public var error = ""
    public var state: PDMVVMValidationState?
    
    open func validate(_ value: Any?) {
        if let validationBlock = validationBlock {
            state = validationBlock(value, error) ? .valid : .invalid
        }
    }
    
    open func invalidate() {
        state = Optional.none
    }
    
}
