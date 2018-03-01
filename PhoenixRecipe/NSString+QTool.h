//
//  NSString+QTool.h
//  ArdezRailTransit
//
//  Created by lijingjing on 29/06/2017.
//  Copyright © 2017 ARdEZ Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (QTool)

+ (NSString *)trimWhitespace:(NSString *)val;//去掉前后空格
+ (NSString *)trimNewline:(NSString *)val;//去掉前后回车符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;//去掉前后空格和回车符


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


+ (NSString *)nowFromdDate:(NSString *)dateString;
- (NSString*)md532BitLower;
- (NSString*)md532BitUpper;
- (NSString *)stringByDeletingHtmlLabel;



/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;
/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;
@end
