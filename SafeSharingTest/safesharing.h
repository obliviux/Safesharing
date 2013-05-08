//
//  safesharing.h
//  safesharing
//
//  Created by Antonio Giarrusso on 25/03/13.
//  Copyright (c) 2013 Antonio Giarrusso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

#define kPrivateKey @"widfhdjeo23" //CHANGE THIS

// ================ REMEMBER THAT: ==================//
// 1) The key must be different from the default value
// 2) The key must be at least 11 charachters
// 3) Choose a strong key to secure data

@interface safesharing : NSObject {
    
}

+(void)AddPasswordCardWithKey:(NSString*)key Name:(NSString *)name User:(NSString*)user Password:(NSString*)password Website:(NSString*)website FrontImageData:(NSData*)frontimagedata;
+(void)GetPasswordCardWithKey:(NSString*)key;
+(BOOL)SafecardisInstalled;
+(NSArray*)ReceivedSafesharingDataWithKey:(NSString*)key;

@end
