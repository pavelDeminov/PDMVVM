//
//  PDBaseModel.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDModel.h"

@implementation PDModel

@synthesize jsonDict = _jsonDict;
@synthesize pdValue = _pdValue;

+ (instancetype)fromTextFile:(NSString *)fileName {
    id instance;
    
    id json = [self jsonFromTextFile:fileName];
    if ([json isKindOfClass:[NSDictionary class]]) {
        instance = [self fromDict:json];
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"json is Array class");
    } else {
        NSAssert(NO, @"json is Unknown class");
    }
    return instance;
}

+ (NSArray <PDModel*>*)arrayFromTextFile:(NSString *)fileName; {
    
    NSArray *array;
    id json = [self jsonFromTextFile:fileName];
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSAssert(NO, @"json is Dictionary class");
    } else if ([json isKindOfClass:[NSArray class]]) {
        array = [self arrayfromArray:json];
    } else {
        NSAssert(NO, @"json is Unknown class");
    }
    
    return array;
}

+ (id)jsonFromTextFile:(NSString *)fileName {
    id jSon;
    if (fileName.length) {
        NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        if (txtFilePath) {
            NSData *data = [NSData dataWithContentsOfFile:txtFilePath];
            NSError *jsonError = nil;
            jSon = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        } else {
            NSAssert(NO, @"file name is wrong");
        }
        
    } else {
        NSAssert(NO, @"file name is nil");
    }
    return jSon;
}

+ (instancetype)fromDict:(NSDictionary *)modelDictionary; {
    PDModel *model = [[self alloc] initWithDict:modelDictionary];
    return model;
}

+ (NSArray <PDModel*>*)arrayfromArray:(NSArray<NSDictionary *>*)jsonDict; {
    NSMutableArray <PDModel *> *array = [NSMutableArray new];
    for (NSDictionary *dict in jsonDict) {
        PDModel *model = [self fromDict:dict];
        [array addObject:model];
    }
    return [NSArray arrayWithArray:array];
}

- (instancetype)initWithDict:(NSDictionary *)jsonDict {
    self = [super init];
    if (self) {
        [self updateWithDict:jsonDict];
    }
    return self;
}

- (void)updateWithDict:(NSDictionary *)modelDictionary {
    [self willUpdate];
    if (![modelDictionary isKindOfClass:[NSNull class]]) {
        _jsonDict = modelDictionary;
    }
    [self didUpdate];
}

- (void)willUpdate {
    NSObject *object = (NSObject *)self.delegate;
    if ([[object class] conformsToProtocol:@protocol(PDItemInfoDelegate)]) {
        [self.delegate itemInfoWillUpdate:self];
    }
}

- (void)didUpdate {
    [self.delegate itemInfoDidUpdate:self];
}

- (void)updateObject:(id)object forKey:(NSString *)key {
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:self.jsonDict];
    [newDict setObject:object forKey:key];
    [self updateWithDict:newDict];
}

#pragma mark PDItemInfo

- (void)setPdDelegate:(id<PDItemInfoDelegate>)pdDelegate {
    self.delegate = pdDelegate;
}

- (id<PDItemInfoDelegate>)pdDelegate {
    return self.delegate;
}

@end
