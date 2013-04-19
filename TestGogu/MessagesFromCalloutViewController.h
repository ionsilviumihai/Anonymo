//
//  MessagesFromCalloutViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/18/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesFromCalloutViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *latitudine;
@property (nonatomic, strong) NSString *longitudine;
@property (nonatomic, strong) NSMutableArray *date;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
