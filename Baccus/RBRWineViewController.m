//
//  RBRWineViewController.m
//  Baccus
//
//  Created by Ruben Berreguero on 01/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import "RBRWineViewController.h"
#import "RBRWebViewController.h"

@interface RBRWineViewController ()

@end

@implementation RBRWineViewController

//Costructor nuestro
-(id)initWithModel:(RBRWineModel *) aModel{
    
    // Cargar un xib u otro según el dispositivo
    // la macro IS_IPHONE la hemos definido en el fichero de precompilado *.pch para tenerla disponible en todo el proyecto
    NSString *nibName = nil;
    if (IS_IPHONE) {
        nibName = @"RBRWineViewControlleriPhone";
    }
    
    
    if (self = [super initWithNibName:nibName bundle:nil]){
        _model= aModel;
        
        //asignamos el titulo
        self.title=aModel.name;
    }
    
    return self;
    
    
}


//NibName lo mismo que un xib, bundle es cmo  una carpeta
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
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
}


//Sincronizamos modelo y vista
//Vista cargada con tamaño y posicion, a punto de aparecer
-(void)viewWillAppear:(BOOL)animated{
    //Vista va a aparecer
    [super viewWillAppear:animated];
    //Sincronizar
    [self syncModelWithView];
    
    //Cambianos e color del navigation controller
    self.navigationController.navigationBar.tintColor= [UIColor colorWithRed:0.5
                                                                       green:0
                                                                        blue:0.13
                                                                       alpha:1];
}

//Apunto de desaparecer
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


//recibir avisos de memoria, desahcer de cualquier cosa que ocupe memoria
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
-(IBAction)displayWeb:(id)sender{
    NSLog(@"Goto to %@", self.model.wineCompanyWeb);
    
    //Creaer un WEbViewControloer
    RBRWebViewController *webVC= [[RBRWebViewController alloc]initWithModel:self.model];
    
    //Hacemos un push, cambiamos la vsta
    //Todo viewCOntroloer tienne na propiedad que es navigatin controller, pueser ser nil o un navigation controler m as con todos con los viewcontroller
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

#pragma mark - Utils

-(void)syncModelWithView{
    
    self.nameLabel.text= self.model.name;
    self.typeLabel.text= self.model.type;
    self.originLabel.text= self.model.origin;
    self.notesLView.text= self.model.notes;
    self.wineryNameLabel.text= self.model.wineCompanyName;
    self.photoView.image= self.model.photo;
    self.grapesLabel.text= [self arrayToString: self.model.grapes];
    
    [self displayRating: self.model.rating];
    
    self.webButton.enabled= (BOOL)self.model.wineCompanyWeb;
    

    
    //[self.notesLabel setNumberOfLines:0]; // AL ser textVieu ya no hace falta para que ponga todas las lienas que hagan faltra
    
    
    // ajustamos los labels según su tamaño o reducimos la fuente en su caso ya que en el iPhone puede ocurrir que no quepa todo el texto
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.wineryNameLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.originLabel.adjustsFontSizeToFitWidth = YES;
   
   
    [self.grapesLabel sizeToFit];
    
    // como las uvas puede tener un tamaño bastante variable (ajustado mediante sizeToFit)
    // necesitamos bastante espacio para las notas movemos subimos el el frame de la nota
    // lo hacemos solo en iPhone por las restricciones obvias de tamaño
    if (IS_IPHONE) {
        CGRect newFrame = self.notesLView.frame;
        CGFloat offset = newFrame.origin.y - (self.grapesLabel.frame.origin.y + self.grapesLabel.frame.size.height + 10);
        newFrame.origin.y = self.grapesLabel.frame.origin.y + self.grapesLabel.frame.size.height + 10;
        newFrame.size.height += fabsf(offset);
        self.notesLView.frame = newFrame;
    }

}

-(void) displayRating: (int) aRating{
    [self clearRatings];
    
    UIImage *glass= [UIImage imageNamed:@"splitView_score_glass.png"];
    
    for (int i=0; i< aRating; i++) {
        [[self.raitingViews objectAtIndex:i] setImage:glass];
    }
    
}

-(void) clearRatings{
    for (UIImageView *imgView in self.raitingViews) {
        imgView.image= nil;
    }
}

-(NSString *) arrayToString: (NSArray *) anArray{
    
    NSString  *repr= nil;
    
    if ([anArray count]==1){
        repr= [@ "100%" stringByAppendingString:[anArray lastObject]];
    }else{
        //El metoto de components... devuelte todas los cobjetos del array separados por la cadena
        //El meotod stringByAppendingString concatena creadno una nueva cadena
        repr= [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}



#pragma mark - UISplitViewControllerDelegate

-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc{
    
    //Añadimos a la barra de navegacion el boton a la izquierda
    self.navigationItem.rightBarButtonItem= barButtonItem;
    
}

-(void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
    //Quitar el boton de la barra
    self.navigationItem.rightBarButtonItem=nil;
}


#pragma mark - WineryTableViewController

//Implementar Metodo delefado
-(void) wineryTableViewController: (RBRWineryTableViewController *) wineryVC
                                    didSelectedWine: (RBRWineModel *) aWine{
    self.model=aWine;
    self.title= aWine.name;
    
    [self syncModelWithView];
    
}



@end
