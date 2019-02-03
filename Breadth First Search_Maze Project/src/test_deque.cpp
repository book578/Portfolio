#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include "deque.hpp"

TEST_CASE( "Test deque pushfront", "[deque]" )
{
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	for(int i = 5; i>0; i--){
		CHECK(mydeque.getLength() == i);
		mydeque.popBack();
	}

}
TEST_CASE( "Test deque getLength", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	for(int i = 5; i>0; i--){
		CHECK(mydeque.getLength() == i);
		mydeque.popBack();
	}
	mydeque.pushFront(1000);
	CHECK(mydeque.getLength() == 1);


}

TEST_CASE( "Test deque isEmpty", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	for(int i = 5; i>0; i--){
		CHECK(mydeque.getLength() == i);
		mydeque.popBack();
	}
	CHECK(mydeque.isEmpty());
}
TEST_CASE( "Test deque front", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	REQUIRE(mydeque.front() ==4);
}
TEST_CASE( "Test deque Pushback", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushBack(i);
	}
	CHECK(mydeque.getLength() ==5);
	for(int i = 0; i < 5; i++){
		int q = mydeque.front();
		CHECK(q == i);
		mydeque.popFront();
		}
}
TEST_CASE( "Test deque back", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	for(int i = 0; i < 5; i++){
		int q = mydeque.back();
		CHECK(q == i);
		mydeque.popBack();
		}
}
TEST_CASE( "Test deque Popback", "[deque]" ) {
	Deque<int> mydeque;
	for(int i = 0; i < 5; i++){
		mydeque.pushFront(i);
	}
	CHECK(mydeque.getLength() ==5);
	int q;
	int A0A = 0;
	int A1A = 1;
	int A2A = 2;
	int A3A = 3;
	int A4A = 4;
	q= mydeque.back();
	CHECK(q == A0A);
	mydeque.popBack();
	q= mydeque.back();
	CHECK(q == A1A);
	mydeque.popBack();
	q= mydeque.back();
	CHECK(q == A2A);
	mydeque.popBack();
	q= mydeque.back();
	CHECK(q == A3A);
	mydeque.popBack();
	q= mydeque.back();
	CHECK(q == A4A);
	mydeque.popBack();
	REQUIRE(mydeque.getLength() ==0);
}

TEST_CASE("Test deque copy assignment operator","[deque]")
{

	Deque<int> mydeque;
	for(int i =0; i <10; i++){
		mydeque.pushFront(i);
	}
	REQUIRE(mydeque.getLength() ==10);
	Deque<int> mydeque2;
	mydeque2 = mydeque;
	REQUIRE(mydeque.getLength() ==10);
	for(int i = 0; i<10;i++){
		CHECK(mydeque2.back() ==i);
		mydeque2.popBack();
	}
	REQUIRE(mydeque2.isEmpty());
	REQUIRE(mydeque2.getLength() ==0);
	REQUIRE(mydeque.getLength() ==10);


	Deque<string> mystringdeque;
	mystringdeque.pushFront("alphabet");
	mystringdeque.pushBack("tangerine");
	mystringdeque.pushFront("xylophone");
	mystringdeque.pushBack("kangaroo");
	REQUIRE(mystringdeque.getLength() == 4);
	Deque<string> mystringdeque2;
	mystringdeque2 = mystringdeque;
	REQUIRE(mystringdeque2.getLength() ==4);
	//test for xylophone
	REQUIRE(mystringdeque2.front() ==mystringdeque.front());
	mystringdeque2.popFront();
	mystringdeque.popFront();

	//test for alphabet
	REQUIRE(mystringdeque2.front() ==mystringdeque.front());
	mystringdeque2.popFront();
	mystringdeque.popFront();
	//test for tangerine
	REQUIRE(mystringdeque2.front() ==mystringdeque.front());
	mystringdeque2.popFront();
	mystringdeque.popFront();
	//test for kangaroo
	REQUIRE(mystringdeque2.front() ==mystringdeque.front());
	mystringdeque2.popFront();
	mystringdeque.popFront();
	//after all 4 checks the deque shoud be empty
	REQUIRE(mystringdeque2.isEmpty());
	REQUIRE(mystringdeque2.getLength() ==0);

}

TEST_CASE("Test deque with copy constructor", "[deque]")
{
Deque<int> myintdeque;
for(int i = 0; i<400; i++){
	myintdeque.pushBack(i);
}
Deque<int> myintdeque2(myintdeque);
myintdeque2.pushBack(1000);
myintdeque2.pushFront(12000);
REQUIRE(myintdeque2.front() ==12000);
//cout <<"my int deque 2 front" << myintdeque2.front() <<endl;
myintdeque2.popFront();
//cout <<"my int deque 2 front after popfront " << myintdeque2.back() <<endl;
REQUIRE(myintdeque2.back() ==1000);
//cout <<"my int deque 2 back  " << myintdeque2.back() <<endl;
myintdeque2.popBack();
//cout <<"my int deque 2 front after popback " << myintdeque2.back() <<endl;
for(int i = 399; i>=0; i--){
	CHECK(myintdeque2.back() ==i);
	myintdeque2.popBack();
}
REQUIRE(myintdeque2.getLength() ==0);
}

