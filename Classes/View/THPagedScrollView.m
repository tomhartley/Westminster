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
    }
    return self;
}

-(void)awakeFromNib {
	[super awakeFromNib];
	showPageControl = YES;
	scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)]; //set in layoutSubviews
	scrollView.delegate = self;
	scrollView.pagingEnabled = YES;
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.contentSize = CGSizeMake([views count]*self.frame.size.width, self.frame.size.height);
	[self addSubview:scrollView];
	pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]; //set in layoutSubviews
	[pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
	pageControl.numberOfPages = 0;
	[self addSubview:pageControl];
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
	[super layoutSubviews];
	
    if (showPageControl) {
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-42);
        pageControl.frame = CGRectMake(0, scrollView.frame.size.height, self.frame.size.width, 42);
    } else {
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
	
	int w = scrollView.frame.size.width;
	int h = scrollView.frame.size.height;
	int margins = w/20;
	scrollView.contentSize = CGSizeMake(w*7, h);
	
	for (int i = 0; i<[views count]; i++) {
		//Get view
		UIView *v = [views objectAtIndex:i];
		//Resize it
		v.frame = CGRectMake(w*i+margins,0,w-(margins*2),h);
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

- (void)setViews:(NSArray *)newViews {
	[views autorelease];
	views = [newViews retain];
	//Out with the old...
	[[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];	
	//and in with the new!
	pageControl.numberOfPages = [views count];
	for (UIView *v in views) {
		[scrollView addSubview:v];
	}
	[self setNeedsLayout];
}
@end
