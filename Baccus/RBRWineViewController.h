//
//  RBRWineViewController.h
//  Baccus
//
//  Created by Ruben Berreguero on 01/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBRWineModel.h"
#import "RBRWineryTableViewController.h"

//Hemos puesto como delefado del SplitViewController
@interface RBRWineViewController : UIViewController <UISplitViewControllerDelegate, WineryTableViewControllerDelegate>



//Crear propiedades

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *wineryNameLabel; //Bodega
@property(weak, nonatomic) IBOutlet UILabel *typeLabel;
@property(weak, nonatomic) IBOutlet UILabel *originLabel;
@property(weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property(weak, nonatomic) IBOutlet UITextView *notesLView;
@property(weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *raitingViews;
@property (weak, nonatomic) IBOutlet UIButton *webButton;

@property (strong,nonatomic) RBRWineModel *model;




//Iniciliciador propio
-(id)initWithModel:(RBRWineModel *) aModel;

//Mensaje acepta cualquer objeto, devuelve IBACTion
-(IBAction)displayWeb:(id)sender;


@end
