//
//  Util.h
//  Note
//
//  Created by mini on 2017/11/22.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (BOOL)isIphoneX;
+ (BOOL)isIphone40orLow;
+ (BOOL)isIphone47;
+ (BOOL)isIphone55;


+ (void)saveDefaultValue:(id)value forKey:(NSString *)key;
+ (id)getDefaultWithKey:(NSString *)key;




+ (NSArray <NSNumber *>*)getRandomLaunchId:(NSInteger)count;
+ (NSArray <NSNumber *>*)getSnacksId:(NSInteger)count;
+ (NSArray <NSNumber *>*)getRandomId:(NSInteger)count;


// Get IP Address
- (NSString *)getIPAddress ;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (BOOL)isValidatIP:(NSString *)ipAddress ;
+ (NSDictionary *)getIPAddresses;
@end
