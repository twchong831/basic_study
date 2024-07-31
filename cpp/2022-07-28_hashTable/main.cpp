#include <iostream>
#include <string>
#include <unordered_map>

int main()
{
	std::unordered_map<std::string, int> um;

	if(um.empty())
	{
		printf("unordered map is empty...\n");
	}

	um.insert(std::make_pair("key", 1));
	um["banana"] = 2;
	um.insert({"melon", 3});

	printf("um size is %d\n", um.size());

	for(std::pair<std::string, int> elem : um)
	{
		// printf(" key : %s, value : %d\n", elem.first, elem.second);
		std::cout << "key : " << elem.first << " value : " << elem.second << std::endl;
	}

	if(um.find("banana") != um.end())
	{
		um.erase("banana");
	}

	printf("um size is %d\n", um.size());

	for(auto elem : um)
	{
		// printf(" key : %s, value : %d\n", elem.first, elem.second);
		std::cout << "key : " << elem.first << " value : " << elem.second << std::endl;
	}

	return 0;
}