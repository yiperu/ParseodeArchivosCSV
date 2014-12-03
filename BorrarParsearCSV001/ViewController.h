//
//  ViewController.h
//  BorrarParsearCSV001
//
//  Created by Henry AT on 12/3/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CHCSVParser.h"


@interface ViewController : UIViewController <CHCSVParserDelegate>

@property (nonatomic, strong) NSMutableArray * lines;
@property (nonatomic, strong) NSMutableArray * currentLine;

@end

