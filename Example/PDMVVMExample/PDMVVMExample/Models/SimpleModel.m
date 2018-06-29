//
//  Model.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "SimpleModel.h"

@implementation SimpleModel

- (NSString *)pdTitle {
    return [self.jsonDict objectForKey:@"title"];;
}

- (NSString *)pdValue {
    return [self.jsonDict objectForKey:@"value"];;
}

@end
