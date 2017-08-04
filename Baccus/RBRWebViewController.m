//
//  RBRWebViewController.m
//  Baccus
//
//  Created by Ruben Berreguero on 03/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import "RBRWebViewController.h"
#import "RBRWineryTableViewController.h"

@interface RBRWebViewController ()

@end

@implementation RBRWebViewController

-(id) initWithModel: (RBRWineModel *)aModel{

    if (self= [super initWithNibName:nil
                              bundle:nil]){
        _model=aModel;
        //asignamos el titulo
        self.title=@"Web";
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self displayURL: self.model.wineCompanyWeb];
    
    //Alta en notificacion
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    
    //Cadno alguien sea quien sea, os tiene que mandar el mensaje wineDidChange: (hay que crear este metodo)
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
    
}

//Siempre evia la notificacion
-(void)wineDidChange: (NSNotification*) notification{
    NSDictionary *dict= [notification userInfo];
    RBRWineModel *newWine=[dict objectForKey:WINE_KEY];
    
    //Actualizar el modelo
    self.model= newWine;
    
    [self displayURL:self.model.wineCompanyWeb];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Baja de notificacion
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    
    [center removeObserver:self];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
//Metodos del delegado (nombreDelaClase...)
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

#pragma mark- Utils
-(void) displayURL: (NSURL *)aURL{
    
    self.browser.delegate=self; //Indicamos que el delegado somos nosotros msmos
    
    self.activityView.hidden=NO;
    [self.activityView startAnimating];
    
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
    
}


@end
