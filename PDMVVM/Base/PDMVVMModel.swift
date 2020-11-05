//
//  PVMVVMModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 02/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

public protocol PDMVVMModelUpdated {
    func modelUpdated(model: Any)
}

open class PDMVVMModel: NSObject  {
    
    open var updatedDelegate: PDMVVMModelUpdated?
    
    open var mvvmTitle: String?
    open var mvvmApiKey: String?
    open var mvvmImageName: String?
    open var mask: String?
    open var mvvmAPIError:String?
    open var mvvmPlaceholder: String?
    open var mvvmDate: Date?
    open var mvvmValue: Any?
    open var mvvmObject: Any?
    
    open var mvvmImage: UIImage?
    open var mvvmImageUrl: URL?
    open var mvvmError: String? {
        get {
            if (errorRule?.error != nil) {
                return errorRule?.error
            } else if (mvvmAPIError != nil) {
                return mvvmAPIError;
            } else  {
                return nil;
            }
        }
    }
    
    open var type: Int = 0
    
    open var checkers: [Any]?
    open var errorRule: PDMVVMRule?
    open var rules: [PDMVVMRule]?
    
    public init(withTitle title: String?) {
        super.init()
        mvvmTitle = title
    }
    
    public init(withTitle title: String?, image: UIImage?) {
        super.init()
        mvvmTitle = title
        mvvmImage = image
    }
    
    public init(withTitle title: String?, value: Any?) {
        super.init()
        mvvmTitle = title
        mvvmValue = value
    }
    
    public init(withTitle title: String?, value: Any?, error: String?){
        super.init()
        mvvmTitle = title
        mvvmValue = value
        mvvmAPIError = error
    }
    
    open func validate() {
        invalidate()
        if let rules = rules {
            for rule in rules {
                rule.validate(mvvmValue)
                if rule.state == .valid {
                    errorRule = rule
                    break
                }
            }
        }
        
    }
    
    open func invalidate() {
        errorRule = nil
        mvvmAPIError = nil
        
    }
}



