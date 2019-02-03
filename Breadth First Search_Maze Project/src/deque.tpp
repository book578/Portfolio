#include "deque.hpp"

// TODO
#include <cstdlib>
#include <iostream>
#include <algorithm>

using namespace std;

template <typename T>
Deque<T>::Deque()
{
	newNode = nullptr;
	lastnode = nullptr;
	itemcount = 0;
	temp = nullptr;
	popnode = nullptr;

}
template <typename T>
Deque<T>::~Deque()
{
	clear();


}
template<typename T>
Deque<T>::Deque(const Deque<T>& adeque)
{
	//dealing with empty deque list, simply initialize created deque parameters
	if(adeque.itemcount == 0){
		this->newNode = nullptr;
		this->lastnode = nullptr;
		this->itemcount = 0;
		this->temp = nullptr;
		this->popnode = nullptr;;
	}

	//if the deque that is being copied is not empty do the following:
	else{
	lastnode = nullptr;            // Init the lastnod of the list this is vital important.
	itemcount = adeque.itemcount;
	lastnode = adeque.lastnode;
	lastnode = lastnode->next; //start from beginning of queue
	temp = nullptr;
	int count = 0;
	while (count < itemcount)
	{
		// Allocate a new node and set the fields there.
		newNode = new Node;
		newNode->data = lastnode->data;
		
		if(count == 0){
		newNode->prev = nullptr;
		newNode->next =newNode;
		temp = newNode;
		}
		else{
			newNode->prev = temp;
			newNode->next = temp->next;
			temp->next = newNode;
			temp = temp->next;
		
		}

		// Add new node to the local list, keep track of it
		// Shift the loop variable along the passed list.
		lastnode = lastnode->next;
		count +=1;

	}
	lastnode = temp;
	}
}

template <typename T>
Deque<T>& Deque<T>::operator=(const Deque<T> copythisdeque)
{
	

	

		if (this != &copythisdeque) {

	//if the copied deque is empty, then clear current deque
		if(copythisdeque.itemcount == 0){
		clear();
		}
	else{
		// Step 1: Free current memory
		NodePtr temp = copythisdeque.lastnode;
		clear();
		itemcount = 0;

		// Step 2 Create a copy of elements fom copythislist

		for (int i = 0; i < copythisdeque.itemcount; i++) {
			pushFront(temp->data);
			temp = temp->prev;

		}
	}
	return *this;
	}
}

template <typename T>
uintmax_t Deque<T>::getLength()
{
	return itemcount;
}

template<typename T>
bool Deque<T>::isEmpty() const noexcept
{
	return itemcount == 0;
}
template<typename T>
void Deque<T>::pushFront(const T & item)
{

	newNode = new Node; //dynamically create new node
	newNode->data = item; //assign data to new node of item

	//inserting at the front of of link list
	if (itemcount == 0) {
		newNode->prev = nullptr;
		newNode->next = newNode; //since this will be first item in queue, will make it point to itself

		lastnode = newNode; //make last ptr point to new Node
		//cout << "current head value " << head << endl;
		//cout << "current head data " << head->data << endl;
		itemcount += 1;
	}
	else if(itemcount >0) {
		temp = lastnode;
		temp = temp->next;
		newNode->next = temp;
		temp->prev = newNode;
		lastnode->next =temp->prev;
		itemcount += 1;
	}
}
template<typename T>
void Deque<T>::popFront()
{
	if (isEmpty()) {
			throw std::runtime_error("Error: deque is empty nothing to popFront");
		}
	if(getLength() ==1){
		delete lastnode;
		lastnode = nullptr;
		itemcount -=1;
	}
	else{
	NodePtr temp;
	temp = lastnode; //make temp equal to last node
	temp = temp->next; //change temp to point to front of queue
	lastnode->next = temp->next; //update where last node should point to
	popnode = lastnode->next;
	popnode->prev = nullptr; //so that the new first item's prev pointer is nto a dangling pointer
	delete temp; //delete the frist node
	temp = nullptr;
	itemcount -= 1;
	}
}
template<typename T>
T Deque<T>::front() const
{
	if (isEmpty()) {
			throw std::runtime_error("Error: deque is empty nothing to return from front");
		}
	NodePtr temp;
	T item;
	temp = lastnode;
	temp = temp->next;
	item = temp->data;
	return item;

}

template<typename T>
void Deque<T>::clear()
{
	while (!isEmpty()) {
		popBack();
	}
}


template<typename T>
void Deque<T>::pushBack(const T & item) //throw(Error)
{
	newNode = new Node; //dynamically create new node
	newNode->data = item; //assign data to new node of item
	//inserting at the front of of link list
	if (itemcount == 0) {
		newNode->prev = nullptr;
		newNode->next = newNode; //since this will be first item in queue, will make it point to itself

		lastnode = newNode; //make last ptr point to new Node
		//cout << "current head value " << head << endl;
		//cout << "current head data " << head->data << endl;
		itemcount += 1;
	}
	else if(itemcount >0) {
		temp = lastnode;
		newNode->next = temp->next;
		temp->next = newNode;
		newNode->prev = temp;
		lastnode =temp->next;
		itemcount += 1;
	}
}

template<typename T>
void Deque<T>::popBack()
{
	if (isEmpty()) {
		throw std::runtime_error("Error: deque is empty nothing to pop back");
	}
	if(getLength() ==1){
			delete lastnode;
			lastnode = nullptr;
			itemcount -=1;
		}
	else{
	NodePtr prev;
	NodePtr next;
	prev = lastnode->prev;
	next = lastnode->next;
	temp = lastnode;
	lastnode = prev; //change lastnode to point to second to last node
	lastnode->next = next; //allow for the new current last node to point to front of queue
	//cout <<"temp " <<temp <<endl;
	delete temp;
	temp = nullptr;
	itemcount -=1;}
}

template<typename T>
T Deque<T>::back() const
{
	if (isEmpty()) {
			throw std::runtime_error("Error: deque is empty nothing is at the back");
		}
	T item;
	item = lastnode->data;
	return item;
}
