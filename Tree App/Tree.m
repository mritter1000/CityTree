//
//  Tree.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "Tree.h"

@implementation Tree
@synthesize commonName = _commonName;
@synthesize scientName = _scientName;
@synthesize moreInfoUrl = _moreInfoUrl;

+ (id) treeWithCommonName:(NSString *)common_name ScientificName:scient_name InfoUrl:(NSURL *)info_url
{
    Tree *newTree = [[self alloc] init];
    newTree.commonName = common_name;
    newTree.scientName = scient_name;
    newTree.moreInfoUrl = info_url;
    return newTree;
}
-(NSComparisonResult) compareByScientName:(Tree*) tree
{
    return [self.scientName compare:tree.scientName];
}

-(NSComparisonResult) compareByCommonName:(Tree*) tree
{
    return [self.commonName compare:tree.commonName];
}

@end
