//
//  THPagedScrollView.m
//  Westminster
//
//  Created by Network Administrator on 20/03/2012.
//  Copyright (c) 2012 Westminster School. All rights reserved.
//

#import "THPagedScrollView.h"

@implementation THPagedScrollView
@synthesize delegate, views, currentPage, showsPageControl;

- (id)initWithFrame:(CGRect)frame views:(NSArray *)theViews;
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-42) ];
        showPageControl = YES;
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake([views count]*frame.size.width, frame.size.height);
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height, frame.size.width, 42)];
        [pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];

        for (int i; i<[views count]; i++) {
            UIView *v = [views objectAtIndex:i];
            v.frame = CGRectMake((scrollView.frame.size.width * i) + 10, 10, scrollView.frame.size.width-20, scrollView.frame.size.height-20);
        }        
    }
    return self;
}

-(void)setShowPageControl:(BOOL)newShowPageControl {
    showPageControl = newShowPageControl;
    if (showPageControl) {
        pageControl.hidden = NO;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-42);
        pageControl.frame = CGRectMake(0, scrollView.frame.size.height, self.frame.size.width, 42);
    } else {
        pageControl.hidden = YES;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
}

-(void)layoutSubviews {
    if (showPageControl) {
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-42);
        pageControl.frame = CGRectMake(0, scrollView.frame.size.height, self.frame.size.width, 42);
    } else {
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    for (int i; i<[views count]; i++) {
        UIView *v = [views objectAtIndex:i];
        v.frame = CGRectMake((scrollView.frame.size.width * i) + 10, 10, scrollView.frame.size.width-20, scrollView.frame.size.height-20);
    }
}

-(void)setCurrentPage:(NSUInteger)newCurrentPage {
    [self setCurrentPage:newCurrentPage animated:YES];
}

-(void)setCurrentPage:(NSUInteger)newCurrentPage animated:(BOOL)animated {
    [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width*newCurrentPage, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:animated];
    currentPage = newCurrentPage;
    pageControl.currentPage = currentPage;
    
}

-(void)pageControlChanged:(UIPageControl *)pageCont {
    [self setCurrentPage:pageControl.currentPage animated:YES];
    if ([delegate respondsToSelector:@selector(pagedScrollView:didScrollToPageIndex:)]) {
        [delegate pagedScrollView:self didScrollToPageIndex:currentPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView {
	int x = scrollView.contentOffset.x;
    [self setCurrentPage:x/scrollView.frame.size.width animated:NO];
    if ([delegate respondsToSelector:@selector(pagedScrollView:didScrollToPageIndex:)]) {
        [delegate pagedScrollView:self didScrollToPageIndex:currentPage];
    }
}

@end
