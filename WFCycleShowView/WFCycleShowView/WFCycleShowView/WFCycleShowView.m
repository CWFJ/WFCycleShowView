//
//  WFCycleShowView.m
//  自定义广告栏控件
//
//  Created by 开发者 on 15/1/24.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#import "WFCycleShowView.h"

@interface WFCycleShowView () <UIScrollViewDelegate>

/** 图片的个数 */
@property (nonatomic, assign) NSInteger       imageCount;
/** 视图View的大小 */
@property (nonatomic, assign) CGSize          sizeView;
/** 自动滚动定时器 */
@property (nonatomic, strong) NSTimer        *timer;
/** 分页指示器 */
@property (nonatomic, strong) UIPageControl  *pageControl;
/** 滚动显示区 */
@property (nonatomic, strong) UIScrollView   *scrollView;
@end

@implementation WFCycleShowView

- (instancetype)initWithImages:(NSArray *)images
{
    if(self = [super init])
    {
        _imageCount = images.count;                //获取总图片的个数
        _sizeView   = ((UIImage *)images[0]).size; //获取视图的大小（默认第一张图片的大小为视图大小）
        [self viewInitWithImages:images];
    }
    return self;
}

+ (instancetype)cycleShowWithImages:(NSArray *)images
{
    return [[self alloc] initWithImages:images];
}

- (instancetype)initWithImages:(NSArray *)images andSize:(CGSize)size
{
    if(self = [super init])
    {
        _imageCount = images.count;         //获取总图片的个数
        _sizeView   = size;                 //获取视图的大小（默认第一张图片的大小为视图大小）
        [self viewInitWithImages:images];
    }
    return self;
}

+ (instancetype)cycleShowWithImages:(NSArray *)images andSize:(CGSize)size
{
    return [[self alloc] initWithImages:images andSize:size];
}

/**
 *  界面初始化
 *  在调用此函数之间必须保证_imageCount及_sizeView已初始化
 */
- (void)viewInitWithImages:(NSArray *)images
{
    /*************************************************************************************
     *
     *  View初始化
     *
     ************************************************************************************/
    // 创建一个View
    UIView *view = [[UIView alloc] init];
    // 设置view的大小
    view.frame   = CGRectMake(0, 0, _sizeView.width, _sizeView.height);
    
    /*************************************************************************************
     *
     *  scrollView初始化
     *
     ************************************************************************************/
    // 添加一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    // 设置scrollView的大小
    scrollView.frame         = CGRectMake(0, 0, _sizeView.width, _sizeView.height);
    // 设置滚动范围的大小
    scrollView.contentSize   = CGSizeMake(_sizeView.width * _imageCount, _sizeView.height);
    // 默认设置 分页
    scrollView.pagingEnabled = YES;
    // 默认不显示滚动条
    scrollView.showsHorizontalScrollIndicator = FALSE;
    // 设置scrollView监听代理
    scrollView.delegate      = self;
    // 设置自身属性
    self.scrollView = scrollView;
    /*************************************************************************************
     *
     *  添加image
     *
     ************************************************************************************/
    CGRect rectImage = CGRectMake(0, 0, _sizeView.width, _sizeView.height);
    // 添加图片到视图中
    for (int i = 0; i < _imageCount; i++)
    {
        UIImageView *image = [[UIImageView alloc] initWithImage:images[i]]; //创建imageViwe
        // 计算图片位置
        rectImage.origin.x = i * _sizeView.width;
        // 设置图片位置
        image.frame        = rectImage;
        // 添加图片到scrollView中
        [scrollView addSubview:image];
    }
    /*************************************************************************************
     *
     *  分页指示器pageControl
     *
     ************************************************************************************/
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 设置pageControl页数
    pageControl.numberOfPages  = _imageCount;
    // 设置位置
    pageControl.frame = CGRectMake(0, _sizeView.height - 15, _sizeView.width, 10);
    // 设置pageControl属性
    self.pageControl = pageControl;
    
    [view addSubview:scrollView];
    [view addSubview:pageControl];
    [self addSubview:view];     // 增加到视图中
    
    self.frame = view.frame;    // 设置控件自身的frame大小

}

/**
 *  监听用户正在进行滚动事件
 *
 *  @param scrollView 当前滚动的scrollView
 *  TODO: 这儿需要优化
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / _sizeView.width + 0.5;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时器触发执行函数
 */
- (void)timerTrigger
{
    [self.scrollView setContentOffset:CGPointMake(((_pageControl.currentPage + 1) % _imageCount) * _sizeView.width, 0) animated:YES];
}

/**
 *  重写isAutoShow方法
 *
 *  @param isAutoShow 是否自动循环显示
 */
- (void)setIsAutoShow:(BOOL)isAutoShow
{
    if(isAutoShow)
    {
        // 自动展示
        if(!self.timer) // 防止重复设置
        {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerTrigger) userInfo:nil repeats:YES];
        }
    }
    else
    {
        // 停止自动展示
        [self.timer invalidate];
    }
}
@end
