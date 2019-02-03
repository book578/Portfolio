#include "deque.hpp"
#include "image.h"
#include "lodepng.h"
#include <algorithm>
#include <cstdlib>
#include <string>
#include <iostream>
#include <stdint.h>

int main(int argc, char *argv[])
{
  // TODO implement maze path finder
	
	//initialize variables
	Deque<pair<int,int>> visitqrow_col;
	int redpixcount =0;
	//int noexits = 0; //if this count is equal to 4 there are no exits
	//int exitrow;
	//int exitcolumn;
	int startrow, startcolumn;
	string inputfilename;
	string outputfilename;

	//if the argc variable count is not as expected print error message, and return exit_failure
	if(argc != 3){
		cerr<<"Error: Incorrect number of arguments in command line" <<endl;
		return EXIT_FAILURE;
	}
	else{
	inputfilename = argv[1]; //assign inputfile name from command line input

	outputfilename = argv[2];
	}
	try{
	Image<Pixel> inputimage = readFromFile(inputfilename); //load the input image to pathfinder
	Image<Pixel> copyinputimage;
	copyinputimage = inputimage;
	for (int i = 0; i < inputimage.width(); i++) {
		for (int j = 0; j < inputimage.height(); j++) {

			//checking if it is a black, red or white pixel, if pixel is not of those 3 colors, then maze is invalid
			if (inputimage(i, j) != BLACK && inputimage(i, j) != RED && inputimage(i, j) != WHITE) {
				cerr << "Error: the input maze image contains colors other than black, white, or red" << endl;
				return EXIT_FAILURE;

			}
			else {
				if (inputimage(i, j) == RED) {
					inputimage(i, j) == WHITE;
	
					redpixcount += 1; //keeping track of how many red squares in maze, if count >1 return error
				}

			}
		}
	}

	if (redpixcount != 1) {
		cerr << "Error: there is more than 1 red square in maze" << endl;
		return EXIT_FAILURE;
	}			
	inputimage(512, 512) = RED;
	startrow = 512;
	startcolumn = 512;

	 //use pair data structure for row and column to get rid of overhead
	
	int count  = 0;
	int othercount = 0;
	pair<int, int> row_and_col;
	row_and_col.first = startrow;
	row_and_col.second = startcolumn;
	visitqrow_col.pushFront(row_and_col);
	int visitrow = 0;
	int visitcolumn = 0;

	/*implementation of breadth first search below using the dequeue data structure
	 *to solve for the maze, while the queue is not empty a the maze will be explored to find the correct exit
	 */
	while(!visitqrow_col.isEmpty()){
		count +=1;
		visitrow = visitqrow_col.front().first;
		visitcolumn = visitqrow_col.front().second;
		visitqrow_col.popFront();

		//condition to check if the goal is reached then exit and print new maze image
		if(visitrow == 0 ||visitcolumn == 0 ||visitrow ==inputimage.width() -1 ||visitcolumn == inputimage.height() -1){
			cout <<"Solution Found" <<endl;
			copyinputimage(visitrow,visitcolumn) = GREEN;
			writeToFile(copyinputimage,outputfilename);
			writeToFile(inputimage, "outputfilename.png");
			return EXIT_SUCCESS;
		}
		if (inputimage(visitrow + 1, visitcolumn) == WHITE) { row_and_col.first = visitrow + 1; row_and_col.second = visitcolumn; visitqrow_col.pushBack(row_and_col); }
		if (inputimage(visitrow - 1, visitcolumn) == WHITE) { row_and_col.first = visitrow - 1; row_and_col.second = visitcolumn; visitqrow_col.pushBack(row_and_col); }
		if (inputimage(visitrow, visitcolumn - 1) == WHITE) { row_and_col.first = visitrow; row_and_col.second = visitcolumn - 1; visitqrow_col.pushBack(row_and_col); }
		if (inputimage(visitrow, visitcolumn + 1) == WHITE) { row_and_col.first = visitrow; row_and_col.second = visitcolumn + 1; visitqrow_col.pushBack(row_and_col); }
		inputimage(visitrow, visitcolumn)= BLUE;//
		
		/*the below if statements and while loop are used to updated the queue data
		structure, to ensure that size of deque is not too large
		if the below while loop is not implemented then solving for
		the maze will take too long
		*/
		if (count == 100000) {
			count = 0;
			othercount += 1;
			while (visitqrow_col.getLength() > 100000) {
				visitrow = visitqrow_col.front().first;
				visitcolumn = visitqrow_col.front().second;
				visitqrow_col.popFront();
				if (inputimage(visitrow + 1, visitcolumn) == WHITE) { row_and_col.first = visitrow + 1; row_and_col.second = visitcolumn; visitqrow_col.pushBack(row_and_col); }
				if (inputimage(visitrow - 1, visitcolumn) == WHITE) { row_and_col.first = visitrow -1; row_and_col.second = visitcolumn; visitqrow_col.pushBack(row_and_col); }
				if (inputimage(visitrow, visitcolumn -1) == WHITE) { row_and_col.first = visitrow; row_and_col.second = visitcolumn - 1; visitqrow_col.pushBack(row_and_col); }
				if (inputimage(visitrow, visitcolumn + 1) == WHITE) { row_and_col.first = visitrow; row_and_col.second = visitcolumn + 1; visitqrow_col.pushBack(row_and_col); }
				if (visitrow == 0 || visitcolumn == 0 || visitrow == inputimage.width() - 1 || visitcolumn == inputimage.height() - 1) {
					cout << "Solution Found" << endl;
					copyinputimage(visitrow, visitcolumn) = GREEN;
					writeToFile(copyinputimage, outputfilename);
					writeToFile(inputimage, "outputfilename.png");
					return EXIT_SUCCESS;
				}
				else {
					inputimage(visitrow, visitcolumn) = BLUE;
					visitqrow_col.popFront();
				}
			}

		}
	}


	cout <<"No Solution Found" <<endl;
	writeToFile(copyinputimage, outputfilename);
	writeToFile(inputimage, "outputfilename.png");
	
	return EXIT_SUCCESS;

	}
	catch(exception& e) //if file doesnt exit print out error message and return
	{cout <<e.what() <<endl;
	return EXIT_FAILURE;

	}

return EXIT_SUCCESS;
}




