#include"grid.h"
using std::cout;
using std::endl;

//initializing the grid constructor
Coordinate_Grid::Coordinate_Grid()
{
	//a loop to initialize a new array. 
	for (int i = 0; i < 35; i++)
	{
		for (int j = 0; j < 65; j++)
		{
			grid[i][j] = 'x';
			cout << grid[i][j];
		}
		cout << endl;
	}
	cout << endl;
		

}