//
//  Tree.h
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tree : NSObject
@property (nonatomic, strong) NSString *commonName;
@property (nonatomic, strong) NSString *scientName;
@property (nonatomic, strong) NSURL *moreInfoUrl;

+ (id) treeWithCommonName:(NSString *)common_name ScientificName:scient_name InfoUrl: (NSURL*) info_url;

@end
