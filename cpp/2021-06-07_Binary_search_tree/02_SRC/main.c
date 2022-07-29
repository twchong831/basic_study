#include <stdio.h>
#include <stdlib.h>
 
#define WELCOME    printf("Hello World!\n\n")
#define LINE       printf("\n\n<*--------------------------------------*>\n\n");
#define show(x)    LINE; printf("          [Binary Tree output]\n["); showTree(x); printf("]"); LINE;
 
 
typedef struct binary_node {
    
    int data;
 
    struct binary_node *left;
    struct binary_node *right;
 
} BinNode;
 
BinNode *getBinaryNode(void);
void setBinNode(BinNode *ptr, int data, BinNode *left, BinNode *right);
BinNode *addNode(BinNode *ptr, int data);
void showTree(const BinNode *ptr);
void deleteTree(BinNode *ptr);
int getRandomInt(int from, int to);
BinNode *searchTree (BinNode *ptr, int key);
BinNode *deleteNode(BinNode *root, int key);
BinNode *minValueNode(BinNode * node);
 
 
int main(int argc, char const *argv[])
{
    /* code */
    WELCOME;
 
    BinNode *root = NULL;
    BinNode *search = NULL;
 
    for (int i = 0; i < 5; i++)
    {
        root = addNode(root, i*2);
        root = addNode(root, i*(-1));
    }
 
    show(root);
    search = searchTree(root, 8);
    (search != NULL) ? printf("*search Result : %d, address: 0x%p", search->data, search):
                       printf("not Result");
    LINE;
    deleteTree(root);
 
    printf("\n\n");
 
    /* code */
    root = NULL;
 
    for (int i = 0; i < 10; i++)
    {
        root = addNode(root, getRandomInt(1,50));
    }
    show(root);
    deleteTree(root);
 
    /* code */
    root = NULL;
 
    root = addNode(root, 5);
    root = addNode(root, 1);
    root = addNode(root, 8);
    root = addNode(root, 4);
    root = addNode(root, 2);
    root = addNode(root, 6);
    root = addNode(root, 9);
    root = addNode(root, 7);
    root = addNode(root, 3);
 
    
    show(root);  
    
    // 키값을 삭제한다
    root = deleteNode(root, 5);
    root = deleteNode(root, 8);
    root = deleteNode(root, 3);
 
    
    show(root);
    deleteTree(root);
 
    return 0;
}
 
/*--- 하위 노드중 가장 작은 값을 찾아 준다.  ---*/
 
BinNode *minValueNode(BinNode * node)
{   
    // 커서 노드
    BinNode *cur = node;
 
    while(cur && cur->left != NULL ){
        cur = cur->left;
    }
    // printf("리턴한다 %d 0x%p\n", cur->data, cur);
    return cur;
}
 
/*--- 특정 노드 삭제 일반 포인터로 ---*/
 
BinNode *deleteNode(BinNode *root, int key)
{
 
    // root가 NULL 일 경우. 트리가 비어있을 경우.
    if (root == NULL){
        return root;
    }
    // key 가 노드의 키값보다 작거나 큰 경우[하위트리에 이동]
    if (key < root->data){
        root->left = deleteNode(root->left, key);
    } else if (key > root->data){
        root->right = deleteNode(root->right, key);
    } 
    // 키가 노드의 키값과 같은 경우[삭제]    
    else {
 
 
        // 노드의 자녀가 한개일 경우(왼쪽 아니면 오른쪽)
        // 노드 자녀가 없는 경우도 if문에서 삭제된다.
        if(root->left == NULL){
            BinNode *temp = root->right;
            free(root);
            return temp;
        }
        else if (root->right == NULL){
            BinNode *temp = root->left;
            free(root);
            return temp;
        }
        // 노드의 자녀가 두개일 경우(왼쪽 오른쪽 둘다)
        // 오른쪽 서브트리에서 가장 작은 수를 선택한다.
        // printf("여기\n");
        BinNode *temp = minValueNode(root->right);
 
        // LINE
        // printf("root->data : %d, temp->data : %d at 0x%p\n", root->data, temp->data, temp);
 
        root->data = temp->data;       
        // printf("root->data : %d, temp->data : %d\n", root->data, temp->data);
        root->right = deleteNode(root->right, temp->data);
 
    }
    return root;
}
 
/*--- 키값으로 검색 ---*/
 
BinNode *searchTree (BinNode *ptr, int key)
{
    if(ptr == NULL){
        printf("Search Failed (%d)\n", key);
        return NULL;
    } else if (key == ptr->data){
        printf("Search success (%d)\n", key);
        return ptr;
    } else if (key < ptr->data){
        searchTree(ptr->left, key);
    } else {
        searchTree(ptr->right, key);
    }
}
 
/*--- 랜덤 생성 ---*/
 
int getRandomInt(int from, int to)
{
    int random = rand() % (to-from+1) + from;
    return random;
}
 
/*--- 모든 노드의 메모리 해제 ---*/
 
void deleteTree(BinNode *node)
{
    if(node != NULL){
        deleteTree(node->left);
        deleteTree(node->right);
        free(node);
    }
}
 
/*--- 모든 노드의 데이터를 출력 ---*/
 
void showTree(const BinNode *node)
{
    
    if(node != NULL){
        showTree(node->left);
        printf("%d, ", node->data);
        showTree(node->right);
    }
}
 
/*--- 바이너리 노드 동적할당 ---*/
 
BinNode *getBinaryNode(void)
{
    BinNode *newNode = calloc(1, sizeof(BinNode));
 
    newNode->data = 0;      // 초기화 0
    newNode->left = NULL;   // 초기값 NULL
    newNode->right = NULL;  // 초기값 NULL
 
    // printf("*[노드 초기화 완료]\n");
    return newNode;
}
 
/*--- 노드 설정 (left노드, right노드)   --*/
 
void setBinNode(BinNode *node, int data , BinNode *left_child, BinNode *right_child)
{
    node->data = data;
    node->left = left_child;
    node->right = right_child;
}
 
int count = 0;
 
BinNode *addNode(BinNode *node, int data)
{
    if (node == NULL){
        node = getBinaryNode();
        setBinNode(node, data, NULL, NULL);
        printf("node generated (%2d), counter : %d\n",node->data, count++);
    } else if (data == node->data){
        printf("*[Binary Tree]\n");
    } else if (data < node->data){
        node->left = addNode(node->left, data);
        // printf("left tree 생성 완료 %d\n", node->left->data);
    } else {
        node->right = addNode(node->right, data);
        // printf("right tree 생성 완료 %d\n", node->right->data);
    }
    // printf("[종료]\n");
    return node;
}
