//
//  PDBaseModel.h
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItemInfo.h"

@class PDModel;

@interface PDModel : NSObject <PDItemInfo>

@property (nonatomic, readonly) NSDictionary *jsonDict;
@property (nonatomic, weak) id <PDItemInfoDelegate> delegate;


+ (instancetype)fromTextFile:(NSString *)fileName;
+ (NSArray <PDModel*>*)arrayFromTextFile:(NSString *)fileName;
+ (instancetype)fromDict:(NSDictionary *)modelDictionary;
+ (NSArray <PDModel*>*)arrayfromArray:(NSArray<NSDictionary *>*)modelsDictinary;

- (instancetype)initWithDict:(NSDictionary *)jsonDict;
- (void)updateWithDict:(NSDictionary *)jsonDict;
- (void)willUpdate;
- (void)didUpdate;

- (void)updateObject:(id)object forKey:(NSString *)key;

@end
