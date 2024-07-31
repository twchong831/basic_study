// 출처 : https://huangdi.tistory.com/96
#include <iostream>

// define node structure
struct Node
{
	/* data */
	int data;
	struct Node* link;	// 연결된 구조체
};

struct HeadNode
{
	/* data */
	Node* head;	//노드를 가리키는 포인터, head
};

class Nodelist
{
private:
	/* data */
public:
	Nodelist(/* args */);
	~Nodelist();

	// 리스트 생성, 헤드 노드
	HeadNode* createList(){
		HeadNode* H = new HeadNode;
		H->head = NULL;
		return H;
	}

	// 리스트의 마지막에 노드 삽입
	void addNode( HeadNode* H, const int &x )
	{
		Node* NewNode = new Node;	// 새로운 노드 생성
		Node* LastNode; 			// 원래 있던 노드의 마지막 노드
		NewNode->data = x;			
		NewNode->link = NULL;

		if( H->head == NULL )		// 리스트가 비어있을 경우
		{
			H->head = NewNode;
			return;
		}

		LastNode = H->head;			// 리스트가 비어 있지 않을 경우, 
									// 연결 라스트의 가장 처음 노드가 마지막 노드를 가리킴.
		while( LastNode->link != NULL )
		{
			LastNode = LastNode->link;	// 리스트의 마지막 노드를 찾는 과정
		}
		LastNode->link = NewNode;		// 마지막 노드를 찾으면, 새 노드를 가리킴.
	}

	// 리스트의 마지막 노드를 삭제
	void deleteNode( HeadNode* H )
	{
		Node* prevNode;		// 삭제되는 노드의 앞 노드
		Node* delNode;		// 삭제되는 노드

		if( H->head == NULL )	// 리스트가 빈 경우
			return;
		// 리스트가 한 개의 노드만 가지고 있는 경우
		if( H->head->link == NULL )
		{
			delete H->head;		// head가 가리키던 메모리 영역 삭제
			H->head = NULL;		// head 노드의 link 부분인 head 값을 Null로 설정
			return;
		}
		else
		{
			// 리스트에 노드가 여러개 있을 경우
			prevNode = H->head;				// head 노드가 가리키는 노드가 prevNode가 되게 설정
			delNode = H->head->link;		// prevNode 다음 위치로 delNode 설정
			while( delNode->link != NULL )	//
			{
				// delNode가 마지막 노드가 될때까지 
				prevNode = delNode;			// prevNod를 한칸씩 가고
				delNode  = prevNode->link;	// delNode도 한칸씩 끝으로 이동
			}
			free(delNode);					// 마지막 노드의 메모리 반환
			prevNode->link = NULL;
		}
	}

	// 리스트의 특정 노드 삭제
	void deleteThisNode( HeadNode* H, const int & deldata)
	{
		Node* delNode;				// 삭제하고자 하는 노드
		Node* prevNode;				// 삭제하고자 하는 노드의 앞 노드
		prevNode = H->head;
		while( prevNode->link->data != deldata )
		{
			printf("searching... %d\n", prevNode->link->data);
			if(prevNode->link->link != NULL)
				prevNode = prevNode->link;
			else
			{
				printf("node link is NULL\n");
				break;
			}
		}
		printf("while end.\n");

		if( prevNode->link->link != NULL )
		{
			delNode = prevNode->link;
			prevNode->link = delNode->link;
			free(delNode);

			printf("%d 값을 가지는 노드가 삭제되었습니다.\n", deldata);
		}
		else
		{
			printf("삭제할 노드를 찾지 못했습니다.\n");
		}
		return;
	}

	// 리스트에 특정 노드 삽입
	void addThisNode( HeadNode* H, const int &afterthisdata, const int &adddata)
	{
		// afterthisdata : 삽입하기 위한 위치
		// adddata : 삽입할 데이터
		Node* prevNode;			// 삽입하려는 노드의 이전 노드
		prevNode = H->head;
		while( prevNode->data != afterthisdata)
		{
			prevNode = prevNode->link;
		}
		Node* NewNode = new Node;
		NewNode->data = adddata;
		NewNode->link = prevNode->link;
		prevNode->link = NewNode;
		return;
	}

	// 리스트의 특정 노드를 검색
	void searchNode( HeadNode* H, const int &thisdata)
	{
		Node* someNode;
		someNode = H->head;
		while( someNode->data != thisdata )
		{
			someNode = someNode->link;
			if(someNode->link == NULL)
			{
				break;
			}
		}
		if(someNode->link != NULL)
			printf("%d Searched Data Success!!\n", thisdata);
		else
			printf("%d element Search Failed..!\n", thisdata);
	}

	void printList( HeadNode *L )
	{
		Node* p;
		printf("List = ( ");
		p = L->head;
		while( p != NULL)
		{
			printf("%d ", p->data);
			p = p->link;
			if( p != NULL )
				printf("-->");
		}
		printf(" )\n");
	}
};

Nodelist::Nodelist(/* args */)
{
}

Nodelist::~Nodelist()
{
}


int main(int argc, char* argv[])
{
	// printf("hello World!\n");
	Nodelist list;
	HeadNode* L; 
	L = list.createList();
	printf("1. 빈 연결 리스트를 생성했습니다.\n");
	int data1, data2, data3;
	printf("2. 연결 리스트에 추가할 노드의 데이터를 3개 정해주세요\n");
	std::cin >> data1 >> data2 >> data3;
	list.addNode(L, data1);
	list.printList(L);
	list.addNode(L, data2);
	list.printList(L);
	list.addNode(L, data3);
	list.printList(L);
	printf("\n");

	printf("3. 탐색할 노드의 데이터를 정해주세요.\n");
	int data4;
	std::cin >> data4;
	list.searchNode(L, data4);
	printf("\n");

	printf("4-1. 어떤 노드 뒤에 노드를 추가할건가요?\n");
	int data5, data6;
	std::cin >> data5;
	printf("4-2. 그 노드 뒤에 어떤 데이터를 가진 노드를 추가하겠습니까?\n");
	std::cin >> data6;
	list.addThisNode(L, data5, data6);
	list.printList(L);
	printf("\n");

	printf("5. 삭제하고 싶은 노드를 알려주세요\n");
	int data7;
	std::cin >> data7;
	list.deleteThisNode(L, data7);
	list.printList(L);
	printf("\n");

	printf("6. 마지막 노드를 삭제합니다.\n");
	list.deleteNode(L);
	list.printList(L);
	
	return 0;
}
