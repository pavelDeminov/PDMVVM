//
//  PVMVVMModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 02/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMModel: NSObject  {
    var mvvmTitle: String?
    var mvvmApiKey: String?
    var mvvmImageName: String?
    var mask: String?
    var mvvmAPIError:String?
    var mvvmPlaceholder: String?
    var mvvmDate: Date?
    var mvvmValue: Any?
    var mvvmObject: Any?
    
    var mvvmImage: UIImage?
    var mvvmImageUrl: URL?
    var mvvmError: String? {
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
    
    var type: Int = 0
    
    var checkers: [Any]?
    var errorRule: PDMVVMRule?
    var rules: [PDMVVMRule]?
    
    init(withTitle title: String?) {
        super.init()
        mvvmTitle = title
    }
    
    init(withTitle title: String?, image: UIImage?) {
        super.init()
        mvvmTitle = title
        mvvmImage = image
    }
    
    init(withTitle title: String?, value: Any?) {
        super.init()
        mvvmTitle = title
        mvvmValue = value
    }
    
    init(withTitle title: String?, value: Any?, error: String?){
        super.init()
        mvvmTitle = title
        mvvmValue = value
        mvvmAPIError = error
    }
    
    func validate() {
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
    
    func invalidate() {
        errorRule = nil
        mvvmAPIError = nil
        
    }
}

extension PDMVVMModel: PDMVVMModelInfo {
    
}


