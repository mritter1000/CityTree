//
//  BinTree.h
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface BinTree : NSObject{
    NSMutableArray *treeTypes;
}
@property (nonatomic) Node *broadLeaved;
@property (nonatomic) Node *conifers;
@property (nonatomic) Node *palms;
@property (nonatomic) Node *palm_like;

@property (nonatomic) Node *parentNode;
@property (nonatomic) NSMutableArray *keyNodes;
@property (nonatomic) NSMutableArray *keyArray;
@property (nonatomic) NSMutableArray *keyNames;
-(id) initWithContentsOfFile:(NSString *) filePath;
- (NSString*) findSppWithName:(NSString*) name;

-(void) makePalmTree;
@end
