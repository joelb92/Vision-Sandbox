//
//  OpenContourHandler.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 04/18/14.
//
//

#import "GLObject.h"
#import "OpenImageHandler.h"
#import "LineSegment2.h"
#import "CvSeqArr.h"
#import "Line2.h"

@interface OpenContourHandler : GLObject
{
	OpenImageHandler*Image;
	CvMemStorage*storage;
	CvSeq*contours;
}
@property (readonly) CvSeq*contours;

- (id)initWithImage:(OpenImageHandler*)im;
- (id)initWithContourPoints:(Vector2Arr)contourPoints;

+ (Vector2)CentroidOfContour:(CvSeq*)contour;
+ (Vector2Arr)CentroidsOfContours:(CvSeqArr)conts;
+ (double)AreaOfControur:(CvSeq*)contour;

+ (Vector2)FurthestPointOnContour:(CvSeq*)contour AlongDirection:(Vector2)direction FromLine:(Line2)line;
+ (Vector2Arr)LineCastContour:(CvSeq*)contour WithLine:(Line2)line;

+ (void)FillContour:(CvSeq*)contour OnImage:(OpenImageHandler*)image With:(cv::Scalar)color;
+ (void)FillContours:(CvSeqArr)contours OnImage:(OpenImageHandler*)image With:(cv::Scalar)color;

- (CvSeqArr)OuterContoursWithAnAreaInRange:(Vector2)range;
- (CvSeqArr)SolidOuterContoursWithAnAreaInRange:(Vector2)range;
- (CvSeqArr)HollowedOuterContoursWithAnAreaInRange:(Vector2)range;

- (CvSeqArr)ContoursInsideContour:(CvSeq*)outerContour WithAnAreaInRange:(Vector2)range;
- (CvSeqArr)SolidContoursInsideContour:(CvSeq*)outerContour WithAnAreaInRange:(Vector2)range;
- (CvSeqArr)HollowedContoursInsideContour:(CvSeq*)outerContour WithAnAreaInRange:(Vector2)range;
@end
