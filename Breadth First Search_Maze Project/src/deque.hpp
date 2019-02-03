#ifndef DEQUE_HPP
#define DEQUE_HPP

#include "abstract_deque.hpp"
#include <stdint.h>
/*this deque will implement a circular deque:
 * the last node in the deque will point to front of deque;
 * the first node in deque; its previous pointer should always be null
 */

template <typename T>
class Deque: public AbstractDeque<T>{

private:

uintmax_t itemcount;

struct Node{
	T data;
	Node* next;
	Node* prev;
};
//create definition for Node pointer as NodePtr
typedef Node* NodePtr;
NodePtr lastnode;
NodePtr temp;
NodePtr popnode;
NodePtr newNode;
T item;

public:
	/**constructor for deque
	 * initialize parameters
	 */
	Deque();

	/*destructor for deque
	 * delete any memory allocated to heap
	 */
	~Deque();

	/*copy contructor for deque
	 *
	 */
	Deque(const Deque &mydeque);

	/*copy-assignment operator overload
	 * overload the operator such that Deque1 = Deque2
	 */
	Deque& operator=(const Deque mydeque);

	/*isEmpty method will return true if deque
	 * is empty, otherwise return false
	 */
	bool isEmpty() const noexcept;

	  /** Add item to the front of the deque
	   * may throw std::bad_alloc
	   */
	 void pushFront(const T & item);

	  /** Remove the item at the front of the deque
	   * throws std::runtime_error if the deque is empty
	   */
	  void popFront();

	  /** Returns the item at the front of the deque
	   * throws std::runtime_error if the deque is empty
	   */
	  T front() const;

	  /** Add item to the back of the deque
	   * may throw std::bad_alloc
	   */
	  void pushBack(const T & item);

	  /** Remove the item at the back of the deque
	   * throws std::runtime_error if the deque is empty
	   */
	  void popBack();


	  /** Returns the item at the back of the deque
	   * throws std::runtime_error if the deque is empty
	   */
	  T back() const;

	  /*clear the queue
	   *
	   */
	  void clear();

	  /*return size of deque
	   *
	   */
	  uintmax_t getLength();

  
};

#include "deque.tpp"

#endif
