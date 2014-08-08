//
//  Ray3.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 3/18/13.
//
//

#import <Foundation/Foundation.h>
#import "Vector3.h"
#import "LineSegment3.h"

#ifndef Ray3_H_
#define Ray3_H_
class Ray3
{
public:
	//Components
	Vector3 origin;
	Vector3 direction;
	
	//Constructors
	Ray3();
	Ray3(Vector3 ORIGIN, Vector3 DIRECTION);
	Ray3(LineSegment3 seg);
	
	//Functions
	Vector3 ProjectionOfPoint(Vector3 point); //Untested in 3D!
	
	//Operators
	LineSegment3 operator* (double parm);
	LineSegment3 operator/ (double parm);
	Ray3 operator-();
	bool operator== (Ray3 Ray3);
	bool operator!= (Ray3 Ray3);
private:
};

#endif