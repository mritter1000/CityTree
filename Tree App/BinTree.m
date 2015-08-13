//
//  BinTree.m
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "BinTree.h"
#import "SpeciesListParser.h"
@implementation BinTree
{
    NSMutableArray *groupArray;
    SpeciesListParser *treeparser;
}

- (id) initWithContentsOfFile: (NSString *) filePath
{
    self = [super init];
    if(self){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TempSpeciesList" ofType:@"csv"];
        treeparser = [[SpeciesListParser alloc] initWithContentsOfFile:path];
        
        NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSMutableArray *group = [[NSMutableArray alloc] init];
        BOOL inGroup = YES;
        groupArray = [[NSMutableArray alloc] init];
        self.keyArray = [[NSMutableArray alloc] init];
        self.keyNames = [[NSMutableArray alloc] init];
        NSString *tempString;
        for (int i = 6; i < [linesArray count]; i++){
            tempString = [linesArray objectAtIndex:i];
            if (![tempString isEqualToString: @""]){
                if([[tempString substringToIndex:5] isEqualToString:@"Group"]){
                    [groupArray addObject:group];
                    group = [[NSMutableArray alloc] init];
                }else{
                    if([[tempString substringToIndex:3]isEqualToString:@"Key"]){
                        [self.keyNames addObject:tempString];
                        if(inGroup){
                            inGroup = NO;
                            [groupArray addObject:group];
                            group = [[NSMutableArray alloc] init];
                        }else{
                            [self.keyArray addObject:group];
                            group = [[NSMutableArray alloc] init];
                        }
                    }else{
                        [group addObject:tempString];
                    }
                }
            }
        }
        treeTypes = [[NSMutableArray alloc] init];
        NSString *treeTypeFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Groups" ofType:@"csv"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *types = [treeTypeFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSString *stringFromTypes;
        NSArray *tempType;
        
        for(int j = 0; j < [types count]; j++){
            stringFromTypes = [types objectAtIndex:j];
            tempType = [stringFromTypes componentsSeparatedByString:@","];
            [treeTypes addObject:tempType];
        }
        
        [self.keyArray addObject:group];
        self.keyNodes = [[NSMutableArray alloc] init];
        [self createTree];
        self.broadLeaved = [self.parentNode.children objectAtIndex:1];
        self.conifers = [self.parentNode.children objectAtIndex:0];
        self.palm_like = [[Node alloc] init];
        self.palm_like.children = [[NSMutableArray alloc] init];
        [self.palm_like.children addObject:[[Node alloc] init]];
        [self.palm_like.children addObject:[[Node alloc] init]];
        [self.palm_like.children addObject:[[Node alloc] init]];
//        self.palm_like.left = [[Node alloc]init];
//        self.palm_like.right = [[Node alloc]init];
        //self addGroupNode:self.palm_like.left
        [self addGroupNode:[self.palm_like.children objectAtIndex:0] InGroup:1 WithIndex:0];
        [self addGroupNode:[self.palm_like.children objectAtIndex:1] InGroup:1 WithIndex:1];
        [self addGroupNode:[self.palm_like.children objectAtIndex:2] InGroup:1 WithIndex:4];
        [self makePalmTree];
        [self makeKeyNodes];
    }
    return self;
}

- (NSString*) findSppWithName:(NSString*) name{
    for(int i = 0; i < [treeTypes count]; i++){
        if([[[treeTypes objectAtIndex:i] objectAtIndex:0]rangeOfString:name].location != NSNotFound){
            return [[treeTypes objectAtIndex:i] objectAtIndex:1];
        }else if([name rangeOfString:[[treeTypes objectAtIndex:i] objectAtIndex:0]].location != NSNotFound){
            return [[treeTypes objectAtIndex:i] objectAtIndex:1];
        }

    }
    NSLog(@"ERRRRORRR");
    return nil;
}

- (void) makeKeyNodes
{
    for(int i = 0; i < [self.keyNames count]; i++){
        [self.keyNodes addObject:[[Node alloc]init]];
        ((Node*)[self.keyNodes objectAtIndex:i]).children = [[NSMutableArray alloc] init];
        [((Node*)[self.keyNodes objectAtIndex:i]).children addObject:[[Node alloc] init]];
        [((Node*)[self.keyNodes objectAtIndex:i]).children addObject:[[Node alloc] init]];
        [self addKeyNode:[((Node*)[self.keyNodes objectAtIndex:i]).children objectAtIndex:0] inKey:i WithIndex:0];
        int rightIndex = [self findPair:@"1’ "  InKey:i WithFirstIndex:0];
        [self addKeyNode:[((Node*)[self.keyNodes objectAtIndex:i]).children objectAtIndex:1] inKey:i WithIndex:rightIndex];
        int thirdIndex = [self findPair:@"1’’" InKey:i WithFirstIndex:0];
        if(thirdIndex != -1){
            [((Node*)[self.keyNodes objectAtIndex:i]).children addObject:[[Node alloc]init]];
            [self addKeyNode:[((Node*)[self.keyNodes objectAtIndex:i]).children objectAtIndex:2] inKey:i WithIndex:thirdIndex];
            int fourthIndex = [self findPair:@"1’’’" InKey:i WithFirstIndex:0];
            if(fourthIndex != -1){
                [((Node*)[self.keyNodes objectAtIndex:i]).children addObject:[[Node alloc]init]];
                [self addKeyNode:[((Node*)[self.keyNodes objectAtIndex:i]).children objectAtIndex:3] inKey:i WithIndex:fourthIndex];
            }

        }
    }
}
- (void) createTree
{
    self.parentNode = [[Node alloc] init];
    self.parentNode.children = [[NSMutableArray alloc] init];
    [self.parentNode.children addObject:[[Node alloc] init]];
    //self.parentNode.right = [[Node alloc] init];
    [self.parentNode.children addObject:[[Node alloc]init]];
    Node *con = ((Node*)[self.parentNode.children objectAtIndex:0]);
    Node *broad = ((Node*)[self.parentNode.children objectAtIndex:1]);
    con.children = [[NSMutableArray alloc]init];
    broad.children = [[NSMutableArray alloc]init];
    
    //conifers
    [con.children addObject:[[Node alloc] init]];
    [self addGroupNode:[con.children objectAtIndex:0] InGroup:0 WithIndex:0];
    
    [con.children addObject:[[Node alloc] init]];
    int rightIndex = [self findPair:@"4’" InGroup:0 WithFirstIndex:0];
    if(rightIndex == -1){
        NSLog(@"HELLLPPP");
    }
    [self addGroupNode:[con.children objectAtIndex:1] InGroup:0 WithIndex:rightIndex];
    int thirdIndex = [self findPair:@"4’’" InGroup:0 WithFirstIndex:0];
    if(thirdIndex != -1){
        [con.children addObject:[[Node alloc]init]];
        [self addGroupNode:[con.children objectAtIndex:2] InGroup:0 WithIndex:thirdIndex];
        NSString *findFourth = [NSString stringWithFormat:@"4’’’"];
        int fourthIndex = [self findPair:findFourth InGroup:0 WithFirstIndex:0];
        if(fourthIndex != -1){
            [con.children addObject:[[Node alloc] init]];
            [self addGroupNode:[con.children objectAtIndex:3] InGroup:0 WithIndex:fourthIndex];
        }
    }
    
    
    
    //broad-leaved trees
    [broad.children addObject:[[Node alloc] init]];
    int index = [self findPair:@"5." InGroup:0 WithFirstIndex:0];
    [self addGroupNode:[broad.children objectAtIndex:0] InGroup:0 WithIndex:index];
    
    [broad.children addObject:[[Node alloc] init]];
    rightIndex = [self findPair:@"5’" InGroup:0 WithFirstIndex:0];
    if(rightIndex == -1){
        NSLog(@"HELLLPPP");
    }
    [self addGroupNode:[broad.children objectAtIndex:1] InGroup:0 WithIndex:rightIndex];
    thirdIndex = [self findPair:@"5’’" InGroup:0 WithFirstIndex:0];
    if(thirdIndex != -1){
        [broad.children addObject:[[Node alloc]init]];
        [self addGroupNode:[broad.children objectAtIndex:2] InGroup:0 WithIndex:thirdIndex];
        NSString *findFourth = [NSString stringWithFormat:@"5’’’"];
        int fourthIndex = [self findPair:findFourth InGroup:0 WithFirstIndex:0];
        if(fourthIndex != -1){
            [broad.children addObject:[[Node alloc] init]];
            [self addGroupNode:[broad.children objectAtIndex:3] InGroup:0 WithIndex:fourthIndex];
        }
    }
    

    
    //[self addGroupNode:self.parentNode.left InGroup:0 WithIndex:0];
    //[self addGroupNode:self.parentNode.right InGroup:0 WithIndex:3];
   // [self addGroupNode:[self.parentNode.children objectAtIndex:0] InGroup:0 WithIndex:0];
    //[self addGroupNode:[self.parentNode.children objectAtIndex:1] InGroup:0 WithIndex:6];
}

- (void) makePalmTree
{
    self.palms = [[Node alloc] init];
    self.palms.children = [[NSMutableArray alloc] init];
    [self.palms.children addObject:[[Node alloc] init]];
    [self.palms.children addObject:[[Node alloc] init]];
    //[self addKeyNode:self.palms.left inKey:0 WithIndex:0];
    //[self addKeyNode:self.palms.right inKey:0 WithIndex:3];
    [self addKeyNode:[self.palms.children objectAtIndex:0] inKey:0 WithIndex:0];
    [self addKeyNode:[self.palms.children objectAtIndex:1] inKey:0 WithIndex:3];
}

- (void) addKeyNode: (Node *) node inKey: (int) keyNum WithIndex: (int) index
{
    NSString *tempString = [[self.keyArray objectAtIndex:keyNum] objectAtIndex:index];
    if([tempString rangeOfString:@"—"].location == NSNotFound){
        node.children = [[NSMutableArray alloc] init];
        [node.children addObject:[[Node alloc]init]];
        [node.children addObject:[[Node alloc]init]];
//        node.left = [[Node alloc] init];
  //      node.right = [[Node alloc] init];
        NSRange rApos = [tempString rangeOfString:@"’"];
        if(rApos.location != NSNotFound){
            tempString = [tempString stringByReplacingOccurrencesOfString:@"’" withString:@""];
        }else{
            NSRange rOriginal = [tempString rangeOfString:@"."];
            if(rOriginal.location != NSNotFound){
                tempString = [tempString stringByReplacingCharactersInRange:rOriginal withString:@""];
            }
        }

        node.text = [tempString substringFromIndex:2];
        NSRange imgRange = [node.text rangeOfString:@"["];
        if(imgRange.location != NSNotFound){
            NSString *imgName = [node.text substringFromIndex:imgRange.location+1];
            imgName = [imgName substringToIndex:imgName.length - 1];
            imgName = [imgName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            node.imgPath = imgName;
            node.text = [node.text substringToIndex:imgRange.location];

        }
        NSString *nextString = [[self.keyArray objectAtIndex:keyNum] objectAtIndex:index + 1];
        NSString *nextident;
        if([nextString characterAtIndex:2] != ' '){
            nextident = [nextString substringToIndex:2];
        }else{
            nextident = [nextString substringToIndex:1];
        }
        [self addKeyNode:[node.children objectAtIndex:0] inKey:keyNum WithIndex:index+1];
        NSString *findRight = [NSString stringWithFormat:@"%@’", nextident];
        int rightIndex = [self findPair:findRight InKey:keyNum WithFirstIndex:index+1];
        [self addKeyNode:[node.children objectAtIndex:1] inKey:keyNum WithIndex:rightIndex];
        NSString *findThird = [NSString stringWithFormat:@"%@’’", nextident];
        int thirdIndex = [self findPair:findThird InKey:keyNum WithFirstIndex:index+1];
        if(thirdIndex != -1){
            [node.children addObject:[[Node alloc]init]];
            [self addKeyNode:[node.children objectAtIndex:2] inKey:keyNum WithIndex:thirdIndex];
        }
        NSString *findFourth = [NSString stringWithFormat:@"%@’’’", nextident];
        int fourthIndex = [self findPair:findFourth InKey:keyNum WithFirstIndex:index+1];
        if(fourthIndex != -1){
            [node.children addObject:[[Node alloc]init]];
            [self addKeyNode:[node.children objectAtIndex:3] inKey:keyNum WithIndex:fourthIndex];
        }
        
    }else{
        NSRange rApos = [tempString rangeOfString:@"’"];
        if(rApos.location != NSNotFound){
            tempString = [tempString stringByReplacingOccurrencesOfString:@"’" withString:@""];
        }else{
            NSRange rOriginal = [tempString rangeOfString:@"."];
            if(rOriginal.location != NSNotFound){
                tempString = [tempString stringByReplacingCharactersInRange:rOriginal withString:@""];
            }
        }
        NSString *textString = [tempString substringFromIndex:2];
        NSRange imgRange = [textString rangeOfString:@"["];
        if(imgRange.location != NSNotFound){
            NSString *imgName = [textString substringFromIndex:imgRange.location+1];
            imgName = [imgName substringToIndex:imgName.length - 1];
            imgName = [imgName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            node.imgPath = imgName;
        }
        node.text = [textString substringToIndex:[textString rangeOfString:@"—"].location];
        NSString *gotoString = [tempString substringFromIndex:[tempString rangeOfString:@"—"].location + 1];
        node.children = [[NSMutableArray alloc] init];
        [node.children addObject:[[Node alloc] init]];
        ((Node *)[node.children objectAtIndex:0]).text = gotoString;
        [treeparser findTreeWithString:gotoString];

    }
}

- (void) addGroupNode: (Node *) node InGroup: (int) groupNum WithIndex: (int) index
{
    NSString *tempString = [[groupArray objectAtIndex:groupNum] objectAtIndex:index];
    if([tempString rangeOfString:@"—"].location == NSNotFound){
        node.children = [[NSMutableArray alloc] init];
        [node.children addObject:[[Node alloc] init]];
        [node.children addObject:[[Node alloc] init]];
        NSRange rApos = [tempString rangeOfString:@"’"];
        if(rApos.location != NSNotFound){
            tempString = [tempString stringByReplacingOccurrencesOfString:@"’" withString:@""];
        }else{
            NSRange rOriginal = [tempString rangeOfString:@"."];
            if(rOriginal.location != NSNotFound){
                tempString = [tempString stringByReplacingCharactersInRange:rOriginal withString:@""];
            }
        }
        node.text = [tempString substringFromIndex:2];
        NSRange imgRange = [node.text rangeOfString:@"["];
        if(imgRange.location != NSNotFound){
            NSString *imgName = [node.text substringFromIndex:imgRange.location+1];
            imgName = [imgName substringToIndex:imgName.length - 1];
            imgName = [imgName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            node.imgPath = imgName;
            node.text = [node.text substringToIndex:imgRange.location];
        }
        NSString *nextString = [[groupArray objectAtIndex:groupNum] objectAtIndex:index + 1];
        NSString *nextident;
        if([nextString characterAtIndex:2] != ' '){
            nextident = [nextString substringToIndex:2];
        }else{
            nextident = [nextString substringToIndex:1];
        }
        [self addGroupNode:[node.children objectAtIndex:0] InGroup:groupNum WithIndex:index+1];
        NSString *findRight = [NSString stringWithFormat:@"%@’", nextident];
        int rightIndex = [self findPair:findRight InGroup:groupNum WithFirstIndex:index+1];
        if(rightIndex == -1){
            NSLog(@"HELLLPPP");
        }
        [self addGroupNode:[node.children objectAtIndex:1] InGroup:groupNum WithIndex:rightIndex];
        NSString *findThird = [NSString stringWithFormat:@"%@’’", nextident];
        int thirdIndex = [self findPair:findThird InGroup:groupNum WithFirstIndex:index+1];
        if(thirdIndex != -1){
            [node.children addObject:[[Node alloc]init]];
            [self addGroupNode:[node.children objectAtIndex:2] InGroup:groupNum WithIndex:thirdIndex];
            NSString *findFourth = [NSString stringWithFormat:@"%@’’’", nextident];
            int fourthIndex = [self findPair:findFourth InGroup:groupNum WithFirstIndex:index+1];
            if(fourthIndex != -1){
                [node.children addObject:[[Node alloc] init]];
                [self addGroupNode:[node.children objectAtIndex:3] InGroup:groupNum WithIndex:fourthIndex];
            }
        }
        /*if([nextident rangeOfString:@"'"].location == NSNotFound){
            NSString *findMe = [NSString stringWithFormat:@"%@'", [nextident substringToIndex:1]];
            NSArray *group = [groupArray objectAtIndex:groupNum];
            for(int i = index + 1; i < [group count]; i++){
        
            }
        }*/
        
    }else{
        NSRange rApos = [tempString rangeOfString:@"’"];
        if(rApos.location != NSNotFound){
            tempString = [tempString stringByReplacingOccurrencesOfString:@"’" withString:@""];
        }else{
            NSRange rOriginal = [tempString rangeOfString:@"."];
            if(rOriginal.location != NSNotFound){
                tempString = [tempString stringByReplacingCharactersInRange:rOriginal withString:@""];
            }
        }
        NSString *textString = [tempString substringFromIndex:2];
        NSRange imgRange = [textString rangeOfString:@"["];
        if(imgRange.location != NSNotFound){
            NSString *imgName = [textString substringFromIndex:imgRange.location+1];
            imgName = [imgName substringToIndex:imgName.length - 1];
            imgName = [imgName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            node.imgPath = imgName;
        }
        node.text = [textString substringToIndex:[textString rangeOfString:@"—"].location];

        NSString *gotoString = [tempString substringFromIndex:[tempString rangeOfString:@"—"].location + 1];
        if([gotoString rangeOfString:@"Group"].location != NSNotFound){
            node.children = [[NSMutableArray alloc] init];
            [node.children addObject:[[Node alloc] init]];
            [node.children addObject:[[Node alloc] init]];
            int groupIndex = [[gotoString substringFromIndex:6]intValue];
            int rightIndex = [self findPair:@"1’ " InGroup:groupIndex WithFirstIndex:1];
            [self addGroupNode:[node.children objectAtIndex:0]InGroup:groupIndex WithIndex:0];
            if(rightIndex == -1){
                NSLog(@"HELLLPPP");
            }

            [self addGroupNode:[node.children objectAtIndex:1] InGroup:groupIndex WithIndex:rightIndex];
            int thirdIndex = [self findPair:@"1’’ " InGroup:groupIndex WithFirstIndex:0];
            if(thirdIndex != -1){
                [node.children addObject:[[Node alloc]init]];
                [self addGroupNode:[node.children objectAtIndex:2] InGroup:groupIndex WithIndex:thirdIndex];
            }
        }else{
            if([gotoString rangeOfString:@"spp"].location != NSNotFound)
            {
                NSString *specString = [gotoString substringFromIndex:[gotoString rangeOfString:@"("].location+1];
                specString = [specString substringToIndex:[specString rangeOfString:@")"].location];
                NSLog(@"%@", specString);
                node.text = [NSString stringWithFormat:@"%@ (%@)", node.text, specString];
                int keyIndex = [self findKeyWithString:tempString];
                if(keyIndex != -1)
                {
                    node.children = [[NSMutableArray alloc] init];
                    [node.children addObject:[[Node alloc] init]];
                    [node.children addObject:[[Node alloc] init]];
                    int numIndex = 0;
                    NSString *goToNum = @"1";
                    if([gotoString rangeOfString:@"{"].location != NSNotFound){
                        NSString *endString = [gotoString substringFromIndex:[gotoString rangeOfString:@"{"].location+1];
                        goToNum = [endString substringToIndex:[endString rangeOfString:@"}"].location ];
                        numIndex = [self findPair:goToNum InKey:keyIndex WithFirstIndex:0];
                        //numIndex = [[ substringToIndex:[gotoString rangeOfString:@"}"].location]intValue];
                    }
                    [self addKeyNode:[node.children objectAtIndex:0] inKey:keyIndex WithIndex:numIndex];

                    int rightIndex = [self findPair:[NSString stringWithFormat:@"%@’ ", goToNum] InKey:keyIndex WithFirstIndex:0];
                    [self addKeyNode:[node.children objectAtIndex:1] inKey:keyIndex WithIndex:rightIndex];
                    int thirdIndex = [self findPair:[NSString stringWithFormat:@"%@’’ ", goToNum] InKey:keyIndex WithFirstIndex:0];
                    if(thirdIndex != -1){
                        [node.children addObject:[[Node alloc]init]];
                        [self addKeyNode:[node.children objectAtIndex:2] inKey:keyIndex WithIndex:thirdIndex];
                        NSString *findFourth = [NSString stringWithFormat:@"%@’’’ ", goToNum];
                        int fourthIndex = [self findPair:findFourth InKey:keyIndex WithFirstIndex:0];
                        if(fourthIndex != -1){
                            [node.children addObject:[[Node alloc]init]];
                            [self addKeyNode:[node.children objectAtIndex:3] inKey:keyIndex WithIndex:fourthIndex];
                        }
                    }
                }
            }
            else
            {
                node.children = [[NSMutableArray alloc] init];
                [node.children addObject:[[Node alloc]init]];
                ((Node *)[node.children objectAtIndex:0]).text = gotoString;
                /*for testing*/
                [treeparser findTreeWithString:gotoString];
            }
            
            //[treeparser findTreeWithString:gotoString];
        }
    }
}
- (int) findPair: (NSString *) findMe InKey: (int) keyNum WithFirstIndex: (int) firstIndex
{
    NSArray *key = [self.keyArray objectAtIndex:keyNum];
    NSString *tempString;
    for(int i = firstIndex; i < [key count]; i++){
        tempString = [key objectAtIndex:i];
        if([tempString rangeOfString:findMe].location != NSNotFound){
            if([tempString rangeOfString:findMe].location == 0){
                return i;
            }
        }
    }
    return -1;
}
- (int) findPair: (NSString *) findMe InGroup:(int) groupNum WithFirstIndex: (int) firstIndex
{
    NSArray *group = [groupArray objectAtIndex:groupNum];
    NSString *tempString;
    for(int i = firstIndex; i < [group count]; i++){
        tempString = [group objectAtIndex:i];
        if([tempString rangeOfString:findMe].location != NSNotFound){
            if([tempString rangeOfString:findMe].location == 0){
                return i;
            }
        }
    }
    return -1;
}

- (int) findKeyWithString: (NSString*) keyString
{
    NSString *gotoString = [keyString substringFromIndex:[keyString rangeOfString:@"—"].location + 1];
    NSString *common = [gotoString substringToIndex: [gotoString rangeOfString:@" ("].location+1];
    common = [common stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *temp;
    for(int i = 0; i < [self.keyNames count]; i++){
        temp = [[self.keyNames objectAtIndex:i] stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([temp rangeOfString:common].location != NSNotFound )
        {
            return i;
        }
    }
    NSLog(@"%@", keyString);
    return -1;
}


@end
