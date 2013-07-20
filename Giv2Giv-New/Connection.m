//
//  Connection.m
//  SnapMenu
//
//  Created by David Hadwin on 4/11/12.
//  Copyright (c) 2012 David Hadwin. All rights reserved.
//

#import "Connection.h"

@implementation Connection
@synthesize _url, _dataToPass, responseData;

-(id)init {
    self = [super init];
    if (self) {
        _url = [[NSString alloc] init];
        _dataToPass = [[NSString alloc] init];
    }
    return self;
}


- (id)responseFromServer {
    id json;
    NSString *appendedURL = [NSString stringWithFormat:@"%@/%@", _url, _dataToPass];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:appendedURL]];
    if (jsonData) {
        json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }else {
        json = @"Error";
    }
    return json;
}
//Use for asynchronous calls
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    [responseData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [responseData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"connectionFinishedLoading");
//    NSLog(@"Response data = %@", responseData);
//}

- (id)responseFromServerJSON:(NSArray *)objects andKeys:(NSArray *)keys {
   
    NSDictionary *variablesDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    //NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:questionDict forKey:@"question"];
    
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:variablesDict options:nil error:nil];
    
    NSLog(@"jsonRequest is %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:_url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    //NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonRequest length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonRequest];

    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[connection start]; //Use for asynchronous calls
    
    id json;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (receivedData) {
        json = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
    } else {
        NSLog(@"Error");
    }
    return json;
    
    
    
    //-------------------------------
}

-(NSString *)uploadBigImage:(UIImage *)image {    
    //Change imageSize
    CGSize size = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Set up variables
    NSData *imageData = UIImageJPEGRepresentation(newImage, 100);
    CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
    CFStringRef uniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);

    //Set up request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:_url]];
    [request setHTTPMethod:@"POST"];

    //Set up boundary
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //Create request body
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", uniqueIDString]; 
    [body appendData:[[NSString stringWithString:disposition] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    //Retrieve request
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    //Add smallPicture
    [self set_url:@"http://www.snapmenu.org/insertPictureSmall.php"];
    [self uploadSmallImage:image withUniqueID:[NSString stringWithFormat:@"small%@", uniqueIDString]];
    
    //Memory Cleanup
    CFRelease(uniqueIDString);
    CFRelease(newUniqueID);

    return returnString;
}

-(NSString *)uploadSmallImage:(UIImage *)image withUniqueID:(NSString *)uniqueID {    
    //Change image size
    CGSize size = CGSizeMake(160, 240);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Set up variables
    NSData *imageData = UIImageJPEGRepresentation(newImage, 100);
   
    //Set up request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:_url]];
    [request setHTTPMethod:@"POST"];
    
    //Set up boundary
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //Create the body
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", uniqueID]; 
    [body appendData:[[NSString stringWithString:disposition] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    //Retrieve request
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    return returnString;
}

@end
