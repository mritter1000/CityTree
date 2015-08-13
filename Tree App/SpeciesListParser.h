//
//  SpeciesListParser.h
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"

@interface SpeciesListParser : NSObject
@property (nonatomic, strong) NSMutableArray *speciesArray;

-(id) initWithContentsOfFile:(NSString *) filePath;
- (Tree*) findTreeWithString:(NSString*) findMe;

@end
