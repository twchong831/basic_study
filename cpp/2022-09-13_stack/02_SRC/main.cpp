#include <iostream>
#include <stack>

int main(int argc, char* argv[])
{
	printf("hello World! : STACK\n");

	std::stack<int> st1;
	std::stack<int> st2;
	st1.push(1);
	st1.push(2);
	st1.push(3);

	st2.push(10);
	st2.push(20);
	st2.push(30);

	swap(st1, st2);
	
	while( !st1.empty() )
	{
		std::cout << st1.top() << std::endl;
		st1.pop();
	}

	return 0;
}
