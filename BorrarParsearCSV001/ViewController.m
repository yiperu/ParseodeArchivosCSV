//
//  ViewController.m
//  BorrarParsearCSV001
//
//  Created by Henry AT on 12/3/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *file = [documentsDirectory stringByAppendingPathComponent:@"eancode1.csv"];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"eancode0" ofType:@"csv"];
    NSLog(@"Ruta del Archivo %@",file);
    
    NSLog(@"Beginning...");
    NSStringEncoding encoding = 0;
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:file];
    CHCSVParser * p = [[CHCSVParser alloc] initWithInputStream:stream usedEncoding:&encoding delimiter:','];
    [p setRecognizesBackslashesAsEscapes:YES];
    [p setSanitizesFields:YES];
    
    NSLog(@"encoding: %@", CFStringGetNameOfEncoding(CFStringConvertNSStringEncodingToEncoding(encoding)));
    
    [p setDelegate:self];
    
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    [p parse];
    NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
    
    NSLog(@"raw difference: %f", (end-start));
    NSLog(@"= = = = = = = = = = = = = = = = = == = = = =");
//    NSLog(@"%@", [d lines]); // Muestra el NSMutableArray
    NSLog(@"Ele 1 de 1 %@", [[[self lines] objectAtIndex:0] objectAtIndex:0]);
    NSLog(@"Ele 2 de 1 %@", [[[self lines] objectAtIndex:0] objectAtIndex:1]);
    NSLog(@"- - - - - - - - - - - --  -- - - - - - - - -");
    NSLog(@"Ele 1 de 2 %@", [[[self lines] objectAtIndex:1] objectAtIndex:0]);
    NSLog(@"Ele 2 de 2 %@", [[[self lines] objectAtIndex:1] objectAtIndex:1]);
    NSLog(@"- - - - - - - - - - - --  -- - - - - - - - -");
    NSLog(@"Ele 1 de 2 %@", [[[self lines] objectAtIndex:2] objectAtIndex:0]);
    NSLog(@"Ele 2 de 2 %@", [[[self lines] objectAtIndex:2] objectAtIndex:1]);
    NSLog(@"/ / / / / / /  / / / / / / / / / / // / / / / ");
    for (NSArray * arregloTemplo in [self lines]) {
        NSLog(@"Ele 1 de 1 %@", [arregloTemplo objectAtIndex:0]);
        NSLog(@"Ele 2 de 1 %@", [arregloTemplo objectAtIndex:1]);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// = = = = = = = = = = = = =  = =  = = = = = = = = = = = =
- (void)parserDidBeginDocument:(CHCSVParser *)parser {
    _lines = [[NSMutableArray alloc] init];
}
- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
    _currentLine = [[NSMutableArray alloc] init];
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
    NSLog(@"%@", field);
    [_currentLine addObject:field];
}
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber {
    [_lines addObject:_currentLine];
    _currentLine = nil;
}
- (void)parserDidEndDocument:(CHCSVParser *)parser {
    //	NSLog(@"parser ended: %@", csvFile);
}
- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", error);
    _lines = nil;
}

@end
