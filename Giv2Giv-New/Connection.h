//
//  Connection.h
//  SnapMenu
//
//  Created by David Hadwin on 4/11/12.
//  Copyright (c) 2012 David Hadwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection : NSObject
{
    NSString *_url;
    NSString *_dataToPass;
    id delegate;
    
}

@property (nonatomic, copy) NSString *_url;
@property (nonatomic, copy) NSString *_dataToPass;
@property (nonatomic, retain) NSMutableData *responseData;

- (id)responseFromServer;
- (id)responseFromServerJSON:(NSArray *)objects andKeys:(NSArray *)keys;
-(NSString *)uploadBigImage:(UIImage *)image;
-(NSString *)uploadSmallImage:(UIImage *)image withUniqueID:(NSString *)uniqueID;

@end
