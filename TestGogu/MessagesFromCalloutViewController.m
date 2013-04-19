//
//  MessagesFromCalloutViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/18/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MessagesFromCalloutViewController.h"
#import "AllMessagesCustomTableCell.h"
#import "httpRequests.h"
#import "viewMessageViewController.h"

@interface MessagesFromCalloutViewController ()

@end

@implementation MessagesFromCalloutViewController
{
    NSMutableArray *cellsArray;
}

@synthesize date, latitudine, longitudine, table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    date = [[NSMutableArray alloc] init];
    [httpRequests getAllMessagessuccess:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            if(([[messagesDict objectForKey:@"latitude"] isEqualToString:latitudine]) && ([[messagesDict objectForKey:@"longitude"] isEqualToString:longitudine]))
            {
                [date addObject:messagesDict];
            }
        }
        NSLog(@"Marime: %d", [date count]);
        [table reloadData];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Mare Eroare!");
    }];
    cellsArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count: %d", [date count]);
    return [date count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //[tableView setSeparatorColor:[UIColor blueColor]];
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    AllMessagesCustomTableCell *cell = (AllMessagesCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.messageLabel.text = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
    [cell.messageLabel sizeToFit];
    // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
    //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
    [cellsArray insertObject:cell atIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if([cellsArray count] != 0 )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
        AllMessagesCustomTableCell *cell = [nib objectAtIndex:0];
        cell = [cellsArray objectAtIndex:indexPath.row];
        if ([cell.textLabel.text length] <25)
        {
            return 150;
        }
        else
            return 203;
    }
    else
        return 203;
     */
    if([date count])
    {
        if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 33)
        {
            return 127;
        }
        else
        {
            if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 65)
            {
                return 145;
            }
            else
            {
                if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 97)
                {
                    return 178;
                }
                else
                {
                    if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 129)
                    {
                        return 200;
                    }
                    else
                    {
                        if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 203)
                        {
                            return 203;
                        }
                    }
                }
            }
        }
    }
    else
    {
        NSLog(@"A intrat in else");
        return 203;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    viewMessageViewController *viewMessageVC = [[viewMessageViewController alloc] initWithNibName:@"viewMessageViewController" bundle:nil];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
    AllMessagesCustomTableCell *cell = [nib objectAtIndex:0];
    cell = [cellsArray objectAtIndex:indexPath.row];
    viewMessageVC.mesaj = cell.messageLabel.text;
    viewMessageVC.idMesaj = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
    [viewMessageVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewMessageVC animated:YES];
}



@end
