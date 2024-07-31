#include <iostream>
#include <algorithm>
#include <vector>
#include <ctime>

//https://blockdmask.tistory.com/178

class Student
{
public:
	std::string name;
	int age;
	Student(std::string name, int age):name(name), age(age){}

	bool operator<(Student s) const{
		// 연산자 오버로딩
		if ( this->name == s.name )
		{
			return this->age < s.age;
		}
		else
		{
			return this->name < s.name;
		}
	}
};


void print_m(int *arr, const int &size_)
{
	std::cout << "arr[i] : ";
	for( int i=0; i<size_; i++ )
	{
		std::cout << arr[i] << " ";
	}
	std::cout << std::endl;
}

void print_s(std::vector<Student> &v)
{
	std::cout << "Student : ";
	for( int i=0; i<v.size(); i++)
	{
		std::cout << "[" << v[i].name << ", " << v[i].age << "]";
	}
	std::cout << std::endl;
}

bool compare(Student a, Student b)
{
	if( a.name == b.name )
	{
		return a.age < b.age;
	}
	else{
		return a.name < b.name;
	}
}

int main(int argc, char* argv[])
{
	printf("hello World! SORT \n");

	int size = 10;
	int arr[10] = {3,7,2,4,1,0,9,8,5,6};

	printf("[Array SORTING]\n");
	print_m(arr, size);
	std::sort(arr, arr+size);	// 오름차순으로 정렬
	printf("sort after....\n");
	print_m(arr, size);

	printf("[Vector SORTING]\n");
	std::vector<int> v;
	std::srand((int)time(NULL));

	for(int i=0; i<size; i++)
	{
		v.push_back(rand() % 10);
	}
	printf("before sorting...\n");
	print_m(v.data(), v.size());
	std::sort(v.begin(), v.end(), std::greater<int>());		// 내림차순으로 정렬
	printf("after sorting...\n");
	print_m(v.data(), v.size());

	printf("[Compare SORTING]\n");
	std::vector<Student> v2;
	v2.push_back(Student("cc", 10));
	v2.push_back(Student("ba", 24));
	v2.push_back(Student("aa", 11));
	v2.push_back(Student("cc", 8));
	v2.push_back(Student("bb", 21));
	printf("before sorting...\n");
	print_s(v2);
	std::sort(v2.begin(), v2.end(), compare);
	printf("after sorting...\n");
	print_s(v2);

	printf("[Operator Sorting]\n");
	std::vector<Student> v3;
	v3.push_back(Student("cc", 10));
	v3.push_back(Student("ba", 24));
	v3.push_back(Student("aa", 11));
	v3.push_back(Student("cc", 8));
	v3.push_back(Student("bb", 21));
	printf("before sorting...\n");
	print_s(v3);
	sort(v3.begin(), v3.end());
	printf("after sorting...\n");
	print_s(v3);
	
	return 0;
}
