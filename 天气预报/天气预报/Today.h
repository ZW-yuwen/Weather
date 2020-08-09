//
//  Today.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/7.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Today : NSObject
@property NSString *tempStr;
@property NSString *highTempStr;
@property NSString *lowTempStr;
@property NSString *dayStr;
@property NSString *sunriseStr;
@property NSString *sunsetStr;
@property NSString *rainStr;
@property NSString *wetStr;
@property NSString *windStr;
@property NSString *bodytemStr;
@property NSString *rainLenghtStr;
@property NSString *pressureStr;
@property NSString *seenStr;
@property NSString *purpleStr;

@end

NS_ASSUME_NONNULL_END
