//
//  Node.h
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property(nonatomic) NSString *text;
@property (nonatomic) NSMutableArray *children;
@property (nonatomic) NSString *imgPath;

@end
