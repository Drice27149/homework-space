#include<stdio.h>  //18342010��һ���ǻ� 
#include<stdlib.h>
#define maxn 648

struct pos{  //��������ı�ʾ rΪrow cΪcolumn 
     int r;
     int c;
};

struct s{  //��ʾsnake headΪͷ������ body������������� ����������β�� ��β�����忪�� 
	
	
	pos head;
	
	pos body[maxn]; int begin,end;
	
}snake;

void put_food();
struct f{   //��ʾfood  
	
	pos now;
	int eat;  //����Ƿ񱻳�  ���ϱ���ֻ��һ��ʳ�� 
}food;

void init(); 

void snake_move(int,int);

int snake_eat();

int is_game_over();

void output();

int main(){
	
	init();  //��ʼ�� ����ߺ�ʳ��ĳ�ʼλ��
	
	char order[2];
	
    while(scanf("%s",order)==1){
    
	if(order[0]=='A'){
		
		snake_move(-1,0);
	}
	
	else if(order[0]=='D'){
		
		snake_move(1,0);
	}
	
	else if(order[0]=='W'){
		
		snake_move(0,-1);
	}
	
	else if(order[0]=='S'){
		
		snake_move(0,1);
	}
	
	else {
		
		printf("Invalid move!\n"); //����ʶ���ָ�� 
	}
	
	if(!is_game_over()) output();
	
	else{
		
		printf("Game over!\n");
		break;
	}
}
	
	return 0;
}

void init(){
	
	snake.head.r=1,snake.head.c=5;
	
	for(int i=0;i<4;i++){  
		
		snake.body[i].c=i+1;
		snake.body[i].r=1;
	}
	
	snake.begin=0,snake.end=4; 
	
	food.eat=0;  
	
	food.now.r=rand()%11;
	food.now.c=rand()%11;
}

void put_food(){
	
	if(food.eat==1){
		
		food.now.r=rand()%11;
		food.now.c=rand()%11;
		food.eat=0;
	}
}

void snake_move(int dx,int dy){ //dxΪx�����ƶ��� dyΪy�����ƶ��� 
    
	snake.body[snake.end].r=snake.head.r;
	snake.body[snake.end].c=snake.head.c;
	
	snake.end++; snake.begin++;  //ԭ����������һ��λ�ó��� ͷ����������һ����� 
	
	snake.head.r+=dy;   
	
	snake.head.c+=dx; 
	
	if(snake_eat()) snake.begin--;  //����һ�� 
}

int snake_eat(){
	
	if(snake.head.r==food.now.r && snake.head.c==food.now.c){
		
		food.eat=1; 
		return 1;
	}
	
	else return 0;
}

int is_game_over(){
	
	if(snake.head.r==0 
	|| snake.head.r==11 
	|| snake.head.c==0
	|| snake.head.c==11 ) return 1;
	
	else {
		
		for(int i=snake.begin;i<snake.end;i++){
			
			if(snake.head.r== snake.body[i].r && snake.head.c==snake.body[i].c)
			return 1;  //ͷ���Ƿ�ײ������ 
		}
	}
	
	return 0;
}

void output(){
	
char map[12][13]=
{"************",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"*          *",
"************"};  //�յ�ͼ

    map[food.now.r][food.now.c]='$'; //���ʳ���ͷ����λ�� 

	map[snake.head.r][snake.head.c]='O';
	
	for(int i=snake.begin;i<snake.end;i++){
		
		printf("%d %d\n",snake.body[i].r,snake.body[i].c);
		
		map[snake.body[i].r][snake.body[i].c]='X';
    }                    
	//����������λ��   
             	
	for(int i=0;i<12;i++){
		
		for(int j=0;j<12;j++){
			
			printf("%c",map[i][j]);
		}printf("\n");
	}
}


