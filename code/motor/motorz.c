/*File name: 		motorz.c
 *Author:			unanao <sunjianjiao@gmail.com>
 *					hqyj <huaqianyujiang@gmail.com>
 *Date Written: 	2009-7-20
 *Last Modified: 	2009-8-12
 *Purpose:			motor conrol --smc800
 *compile:			gcc -lpthread -O2 -o motor0.2 motor0.2.c
 *Brief Description:This will control the motor ,as the received signal
 */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/io.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <sys/select.h>
#define PARPORT 0x378 //the paraport address
#define USECS 50000000


/*
  * global variale declare
 */
static pthread_t pthrdsZ;//Z stand for Z Axis
pthread_t pthrdsZmode; //Thread handle for controling the mode of z motor
pthread_t pthrdsZspeed;//Thread handle for controling the mode of z motor
pthread_t pthrdsgetZmode;//Thread handle for get the z motor mode

//int current[4]={0x17,0x3e,0x37,0x3a};
//int half_step_20_percent[8]={0x37,0x36,0x1E,0x16,0x13,0x12,0x3A,0x32};
/*0 1 2 -->full step 0 -->60%,1-->20%,2-->0%
 *3 4 5 -->half step 3 -->60%,4-->20%,5-->0%
 */
/*the postive of the motor mode*/
int motor_mode[6][8]={{0x2D,0x29,0x09,0x0D},{0x36,0x32,0x12,0x16},{0x3F,0x3B,0x1B,0x1F},{0x2F,0x2D,0x1D,0x0D,0x0B,0x09,0x39,0x29},{0x37,0x36,0x1E,0x16,0x13,0x12,0x3A,0x32},{0x3F,0x3F,0x1F,0x1F,0x1B,0x1B,0x3B,0x3B}};
int motor=2;//stand for z axis
int mode[2]={2,0};
int fd_mode;//the handle of the file of zfifomode
int delaytime=1000000;//The default delay time of every outb
int currmode=0;//the initial mode of the motor x


/*
 *function declare
 */
static void * run();//It is used to run the motor
void stop();//It is used to stop the motor
static void *change_mode(char mode[]);
void getspeed();
void getmode();


void change_motor(unsigned int(*src),int motor)
{
	//if motor=2,when src write to the port ,it will control z 
	(*src)&=0x3F;(*src)|=(motor<<6);
}

/*Basic environment initial 
  *at the same time  control the start and stop of the motor  
 */
int main(int argc,char *argv[])
{
	int fd;
	char message[2];
	int res;
	message[1]='\0';
	/*create fifo file*/
	umask(0);
	if(access("/tmp/zfifo",F_OK)==-1){
		res=mkfifo("/tmp/zfifo",0777);
		if(res==-1){
			printf("create zfifo error\n");
			exit(1);
		}
	}
	if(access("/tmp/zfifomode",F_OK)==-1){
		res=mkfifo("/tmp/zfifomode",0777);
		if(res==-1){
			printf("create zfifomode error\n");
			exit(1);
		}
	}
	if(access("/tmp/zfifospeed",F_OK)==-1){
		res=mkfifo("/tmp/zfifospeed",0777);
		if(res==-1){
			printf("create zfifospeed error\n");
			exit(1);
		}
	}
	printf("if you want to start motor Y,please \necho s>/tmp/yfifo\n");
	printf("if you want to stop motor Y,please \necho e>/tmp/yfifo\n");

	while(1){
		/*if you like to run the x motor ,you can write s to tell the motor*/
		fd=open("/tmp/zfifo",O_RDONLY);
		if(fd==-1){
			perror("open zfifo error\n");
			exit(1);
		}

		if((read(fd,message,sizeof(char)))==-1){
			printf("In the main function ,read zfifo read error\n");
			exit(1);
		}
		/*'s' stand for start ,it means that start the motor */
		if(message[0]=='s'){
			printf("start message=%c\n",message[0]);
			printf("motor run\n");
			pthread_create(&pthrdsZ,NULL,run,NULL);
		}
		/*if you tell the motor stop ,it will stop
		  e stand for 'end' */
		if(message[0]=='e'){
			printf("motor stop\n");
			stop();
		}
		close(fd);
	}
	unlink("/tmp/zfifo");
	unlink("/tmp/zfifomode");
	unlink("/tmp/zfifospeed");
}

/*run the motor only for z axis
 *get the mode of the motor we want the motor to run
 *if we give another motor,the function cacel the previous mode ,and tell
 *the motor run as we told it
 */

static void * run()
{
	int i;
	int flag=0;
	int fd_speed;	
	if((ioperm(PARPORT,3,1))!=0){
		printf("There is no permission to the port\n");
		exit(1);
	} 
	
	/*create a thread to receive speed of z motor*/
	if(pthread_create(&pthrdsZspeed,NULL,(void *)getspeed,NULL)){
		printf("create pthreadZspeed error!\n");
		exit(1);
	}
	/*create a thread to receive the mode of the z motor*/			
	if(pthread_create(&pthrdsgetZmode,NULL,(void *)getmode,NULL)) {
		printf("create pthreadZmod error!\n");
		exit(1);
	}
  /*create a thread to run the motor*/
    if(pthread_create(&pthrdsZmode,NULL,(void *)change_mode,NULL)){
		printf("create pthreadzmode error");
		exit(1);
	}
	
	/*receive speed from zfifospeed*/
	if((ioperm(PARPORT,3,0))!=0){
		printf(" disable error\n");
		exit(1);
	}
}

/*change the mode of motor
 *each motor has 6 modes,each mode is made up by different numbers
 *let which mode to run,we should outb different modes
 */

static void *change_mode(char mode[2])
{
	int max,data;
	struct timespec ts;
	ts.tv_sec=0;
	ts.tv_nsec=USECS;
	//ts.tv_nsec=delaytime;
	int i;
	while(1){
		if(currmode<3){
			max=4;
		}
		if(2<currmode&&currmode<7){
			max=8;
		}
		printf("mode:%d\n",currmode);
		for(i=0;i<max;i++)	{	
			//data=current[i];
			data=motor_mode[currmode][i];
			printf("%0x ",data);
			change_motor(&data,motor);
			outb(data,PARPORT);
			//control port:base_address +2
			outb(0xFF,PARPORT+2);
			outb(data,PARPORT);
			outb(0x00,PARPORT+2);
			//	nanosleep(&ts,NULL);
			usleep(delaytime);
			printf("delaytime=%d\n",delaytime);
		}
	}

}

/*get the speed of z motor
 *it will change the speed of z motor
 *the time tetween two outb is delaytime
 *the longer the delaytime is ,the  slower the speed is 
 *the shorter the delaytime is ,the faster the speed is
 */

void getspeed()
{
	int fd_speed;
	char speedinfo[10];
	int n;
	while(1){
		fd_speed=open("/tmp/zfifospeed",O_RDONLY);
		if(fd_speed==-1){
			printf("open yfifospeed error!\n");
			exit(1);
		}
		if((n=read(fd_speed,speedinfo,10*sizeof(char)))==-1){
			perror("read yfifospeederror!\n");
			exit(1);
		}
		speedinfo[n]='\0';
		delaytime=atoi(speedinfo);
		printf("delaytime:%d\n",delaytime);
		close(fd_speed);
	}
}

/*get the mode of the y motor
 *this function will get the realtime mode of the motor y
 */
void getmode()
{
	int i;
	int fd_mode;
	char mode[2];
	mode[1]='\0';

	while(1){
		fd_mode=open("/tmp/zfifomode",O_RDONLY);
		if(fd_mode==-1){
			printf("open zfifomode error!\n");
			exit(1);	
		}

		if((read(fd_mode,mode,2*sizeof(char)))==-1){
			printf("in run function read zfifomode error\n");
			exit(1);
		}
		currmode=atoi(mode);
		close(fd_mode);
	}
}


/*
 *If this function is called ,the motor will stop
 */

void stop()
{
	pthread_cancel(pthrdsZmode);
	pthread_cancel(pthrdsZ);
	pthread_cancel(pthrdsZspeed);
	pthread_cancel(pthrdsgetZmode);
	printf("motor stoped\n");
}
