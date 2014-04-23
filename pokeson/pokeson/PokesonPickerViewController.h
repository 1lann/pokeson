//
//  PokesonManagerViewController.h
//  pokeson
//
//  Created by Jason Chu on 3/30/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokesonManager.h"
#import "PokesonInfoViewController.h"

@interface PokesonPickerViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *pickerView;

@end
