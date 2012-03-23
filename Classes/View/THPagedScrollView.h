//
//  THPagedScrollView.h
//  Westminster
//
//  Created by Network Administrator on 20/03/2012.
//  Copyright (c) 2012 Westminster School. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocolololololol
@class THPagedScrollView;

@protocol THPagedScrollViewDelegate

@optional

-(void)pagedScrollView:(THPagedScrollView *)pagedScrollView didScrollToPageIndex:(NSUInteger)index;

@end


@interface THPagedScrollView : UIView <UIScrollViewDelegate> {
    NSArray *views;
    BOOL showPageControl;
    NSUInteger currentPage;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSObject <THPagedScrollViewDelegate> *delegate;
}

@property (nonatomic, assign) id <THPagedScrollViewDelegate> delegate;
@property (nonatomic, retain) NSArray *views;
@property (nonatomic) NSUInteger currentPage; //Animated by default, if you want to disable them use the setCurrentPage:animated: method
@property (nonatomic) BOOL showsPageControl;

-(void)setCurrentPage:(NSUInteger)newCurrentPage animated:(BOOL)animated;
-(void)pageControlChanged:(UIPageControl *)pageCont;

@end

