//
//  AvVector2.cpp
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "AvVector2.h"

AvVector2::AvVector2()
{
	Average = Vector2();
	NumberOfPoints = 0;
}
AvVector2::AvVector2(Vector2 vect)
{
	Average = vect;
	NumberOfPoints = 1;
}

void AvVector2::AddVector2(Vector2 p)
{
	Average = Average*NumberOfPoints + p;
	NumberOfPoints++;
	Average = Average/NumberOfPoints;
}
void AvVector2::AddAvVector2(AvVector2 p)
{
	Average = Average*NumberOfPoints + p.Average*p.NumberOfPoints;
	NumberOfPoints += p.NumberOfPoints;
	Average = Average/NumberOfPoints;
}
void AvVector2::resetWithVector2(Vector2 vect)
{
	Average = vect;
	NumberOfPoints = 1;
}