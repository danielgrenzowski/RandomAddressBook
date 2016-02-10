//
//  DetailViewController.h
//  RandomAddressBook
//
//  Created by Danny G on 2016-02-10.
//  Copyright © 2016 DGInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

