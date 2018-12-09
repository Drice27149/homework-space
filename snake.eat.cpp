#include<stdio.h>  //18342010软一陈星辉 
#include<stdlib.h>
#define maxn 648

struct pos{  //方便坐标的表示 r为row c为column 
     int r;
     int c;
};

struct s{  //表示snake head为头部坐标 body是身体坐标队列 队首是身体尾端 队尾是身体开端 
	
	
	pos head;
	
	pos body[maxn]; int begin,end;
	
}snake;

void put_food();
struct f{   //表示food  
	
	pos now;
	int eat;  //标记是否被吃  场上保持只有一个食物 
}food;

void init(); 

void snake_move(int,int);

int snake_eat();

int is_game_over();

void output();

int main(){
	
	init();  //初始化 获得蛇和食物的初始位置
	
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
		
		printf("Invalid move!\n"); //不可识别的指令 
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

void snake_move(int dx,int dy){ //dx为x方向移动量 dy为y方向移动量 
    
	snake.body[snake.end].r=snake.head.r;
	snake.body[snake.end].c=snake.head.c;
	
	snake.end++; snake.begin++;  //原本身体的最后一节位置出队 头部变成身体第一节入队 
	
	snake.head.r+=dy;   
	
	snake.head.c+=dx; 
	
	if(snake_eat()) snake.begin--;  //增长一节 
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
			return 1;  //头部是否撞上身体 
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
"************"};  //空地图

    map[food.now.r][food.now.c]='$'; //获得食物和头部的位置 

	map[snake.head.r][snake.head.c]='O';
	
	for(int i=snake.begin;i<snake.end;i++){
		
		printf("%d %d\n",snake.body[i].r,snake.body[i].c);
		
		map[snake.body[i].r][snake.body[i].c]='X';
    }                    
	//获得蛇身体的位置   
             	
	for(int i=0;i<12;i++){
		
		for(int j=0;j<12;j++){
			
			printf("%c",map[i][j]);
		}printf("\n");
	}
}


