#include <iostream>
#include <queue>

int main(int argc, char* argv[])
{
	printf("hello World! Que\n");

	std::queue<int> q1;
	std::queue<int> q2;
	
	q1.push(1);
	q1.push(2);
	q1.push(3);

	q2.push(10);
	q2.push(20);
	q2.push(30);

	swap(q1, q2);

	while( !q1.empty() )
	{
		std::cout << q1.front() << std::endl;
		q1.pop();
	}
	return 0;
}
