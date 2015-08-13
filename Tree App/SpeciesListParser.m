//
//  SpeciesListParser.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "SpeciesListParser.h"
#import "BinTree.h"

@implementation SpeciesListParser
@synthesize speciesArray = _speciesArray;

-(id) initWithContentsOfFile:(NSString *) filePath
{
    self = [super init];
    if(self){
        self.speciesArray = [[NSMutableArray alloc] init];
        NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

        NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        NSArray *tempTree;
        NSString *stringFromLines;
        for(int i = 1; i < [linesArray count]; i++){
            stringFromLines = [linesArray objectAtIndex:i];
            tempTree = [stringFromLines componentsSeparatedByString:@","];
            [self.speciesArray addObject:[Tree treeWithCommonName:[tempTree objectAtIndex:1] ScientificName:[tempTree objectAtIndex:0] InfoUrl:[NSURL URLWithString:[tempTree objectAtIndex:2]]]];
        }
        self.speciesArray = [[NSMutableArray alloc] initWithArray:[self.speciesArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *scient1 = ((Tree*) obj1).scientName;
            NSString *scient2 = ((Tree*) obj2).scientName;
            return [scient1 compare:scient2];
        }]];

    }
    return self;
}


- (Tree*) findTreeWithString:(NSString*) findMe
{
    NSString *scientName = [findMe substringFromIndex: [findMe rangeOfString:@"("].location+1];
    scientName = [scientName substringToIndex:[scientName rangeOfString:@")"].location];
    int min = 0, max = [self.speciesArray count] - 1;
    int mid;
    //scientName = [scientName stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([scientName rangeOfString:@"Sequo"].location != NSNotFound){
        //NSLog(@"%@", scientName);
    }
    while(max >= min)
    {
        mid = (max + min) / 2;
        NSString *temp = ((Tree*)[self.speciesArray objectAtIndex:mid]).scientName;
        
        //temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([scientName compare:temp] == NSOrderedDescending)
        {
            min = mid + 1;
        }else if([scientName compare:temp] == NSOrderedAscending){
            max = mid -1;
        }else{
            return [self.speciesArray objectAtIndex:mid];
        }
    }
    NSLog(@"%@", scientName);
    return nil;
}

@end
