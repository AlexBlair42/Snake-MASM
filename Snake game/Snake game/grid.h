#ifndef _GRID_H_
#define _GRID_H_

#include<iostream>


class Coordinate_Grid
{
private:
	int max_x = 65;	//designates how large the grid will be horizontally *Note: must be unsigned
	int max_y = 35;	//designates how large the gird will be vertically *Note: must be unsigned
	char grid[35][65];						//dynamically allocate a 2-d array in order to use max_x and max_y as arguments 

public:
	//get the maximum value of x
	int getX()
	{
		return max_x;
	}
	//get the maximum value of y
	int getY()
	{
		return max_y;
	}
		
	//default construcor
	Coordinate_Grid();
	
	


};
#endif
