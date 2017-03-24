//
//  MyQRViewController.m
//

#import "MyQRViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"


#define kBtnX           [UIScreen mainScreen].bounds.size.width*1/5
#define kBtnY           (([UIScreen mainScreen].bounds.size.height-kQRY-kQRHeight-kBtnHeight)/2+kQRY+kQRHeight)
#define kBtnWidth       [UIScreen mainScreen].bounds.size.width*3/5
#define kBtnHeight      40

#define kQRX            [UIScreen mainScreen].bounds.size.width*1/10
#define kQRY            [UIScreen mainScreen].bounds.size.height/4
#define kQRWidht        [UIScreen mainScreen].bounds.size.width*4/5
#define kQRHeight       kQRWidht

static NSString *detailString = @"https://github.com/honeycao";
static NSString *goodsString = @"6944551723107";
static NSString *payString = @"283657461695996598";
@interface MyQRViewController ()

//二维码
@property (nonatomic, strong) UIView *qrView;
@property (nonatomic, strong) UIImageView* qrImgView;

//条形码
@property (nonatomic, strong) UIView *tView;
@property (nonatomic, strong) UIImageView *tImgView;


@end

@implementation MyQRViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(kBtnX, kBtnY, kBtnWidth, kBtnHeight)];
    [btn1 setTitle:@"切换码的样式及类型" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newCodeChooose) forControlEvents:UIControlEventTouchUpInside];
    
    btn1.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:btn1];
   
    
    //二维码
    self.qrView = [[UIView alloc]initWithFrame:CGRectMake( kQRX, kQRY, kQRWidht, kQRHeight)];
    [self.view addSubview:_qrView];
    _qrView.backgroundColor = [UIColor whiteColor];
    _qrView.layer.shadowOffset = CGSizeMake(0, 2);
    _qrView.layer.shadowRadius = 2;
    _qrView.layer.shadowColor = [UIColor blackColor].CGColor;
    _qrView.layer.shadowOpacity = 0.5;
    
    
    self.qrImgView = [[UIImageView alloc]init];
    _qrImgView.bounds = CGRectMake(0, 0, kQRWidht-12, kQRHeight-12);
    _qrImgView.center = CGPointMake(kQRWidht/2, kQRHeight/2);
    [_qrView addSubview:_qrImgView];
//    self.qrView = view;
    
    
    //条形码
    self.tView = [[UIView alloc]initWithFrame:CGRectMake( kQRX,
                                                         kQRY*1.5,
                                                         kQRWidht,
                                                         kQRHeight*0.5)];
    [self.view addSubview:_tView];
  
    
    self.tImgView = [[UIImageView alloc]init];
    _tImgView.bounds = CGRectMake(0, 0, CGRectGetWidth(_tView.frame)-12, CGRectGetHeight(_tView.frame)-12);
    _tImgView.center = CGPointMake(CGRectGetWidth(_tView.frame)/2, CGRectGetHeight(_tView.frame)/2);
    [_tView addSubview:_tImgView];
    
  
    
    [self createQR1];
    
}

- (void)newCodeChooose
{
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showActionSheetWithTitle:@"" message:nil chooseBlock:^(NSInteger buttonIdx) {
        
        if (buttonIdx==1) {
            [weakSelf createQR1];
        }
        else if (buttonIdx == 2)
        {
            [weakSelf createQR2];
        }
        else if (buttonIdx == 3)
        {
            [weakSelf createQR3];
        }
        else if (buttonIdx == 4)
        {
            [weakSelf createCodeEAN13];
        }
        else if (buttonIdx == 5)
        {
            [weakSelf createCode93];
        }
        
    } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitle:@"二维码+logo",@"二维码上色",@"二维码前景颜色+背景颜色",@"商品条形码",@"code93(支付宝付款条形码)",nil];
}


- (void)createQR1
{
    _qrView.hidden = NO;
    _tView.hidden = YES;
    
    
    //如果想要圆角效果，建议还是将图像做成圆角的，或者通过logo图像做成UIImageView加在二维码上面即可
     UIImage *qrImg = [LBXScanWrapper createQRWithString:detailString size:_qrImgView.bounds.size];
    
    UIImage *logoImg = [UIImage imageNamed:@"logo.JPG"];
    _qrImgView.image = [LBXScanWrapper addImageLogo:qrImg centerLogoImage:logoImg logoSize:CGSizeMake(30, 30)];
    
}

- (void)createQR2
{
    _qrView.hidden = NO;
    _tView.hidden = YES;
    
    UIImage *image = [LBXScanWrapper createQRWithString:detailString size:_qrImgView.bounds.size];
    //二维码上色
    _qrImgView.image = [LBXScanWrapper imageBlackToTransparent:image withRed:255.0f andGreen:74.0f andBlue:89.0f];
    
}

- (void)createQR3
{
    _qrView.hidden = NO;
    _tView.hidden = YES;
    
    //生成的不好识别，自己去调好颜色应该就可以识别了
    _qrImgView.image = [LBXScanWrapper createQRWithString:detailString
                                                 QRSize:_qrImgView.bounds.size
                                                QRColor:[UIColor colorWithRed:200./255. green:84./255. blue:40./255 alpha:1.0]
                                                bkColor:[UIColor colorWithRed:41./255. green:130./255. blue:45./255. alpha:1.0]];
}

//商品条形码
- (void)createCodeEAN13
{
    _qrView.hidden = YES;
    _tView.hidden = NO;
    
    _tImgView.image = [LBXScanWrapper createCodeWithString:goodsString size:_qrImgView.bounds.size CodeFomart:AVMetadataObjectTypeEAN13Code];
}

- (void)createCode93
{
    _qrView.hidden = YES;
    _tView.hidden = NO;
    
    //支付宝付款码-条款码
    _tImgView.image = [LBXScanWrapper createCodeWithString:payString size:_qrImgView.bounds.size CodeFomart:AVMetadataObjectTypeCode128Code];
}



@end
