#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<time.h>
#include<string.h>

#define n 10001 //元素总数

void QuickSort(int array[], int left, int right){
  int i, j, key;
	if (left >= right)
		return;
	i = left; j = right;
	key = array[i];
	while (i < j)
	{
		while (i < j && array[j] > key)
			j--;
		if (i < j)
			array[i++] = array[j];

		while (i < j && array[i] < key)
			i++;
		if (i < j)
			array[j--] = array[i];
	}
	array[i] = key;

	QuickSort(array, left, i - 1);
	QuickSort(array, i + 1, right);
}

int count(int x, int S[], int small){
  int a = 0;
  if(small){
    for(int i = 0; i < n; i++){
      if(S[i]<x)
        a++;
    }
  }
  else{
    for(int i = 0; i < n; i++){
      if(S[i]>x)
        a++;
    }
  }
  return a;
}

double LazySelect(){
  clock_t start, end, start2, end2;
  start = clock();
  //生成数组S
  int S[n];
  srand((unsigned int)time(NULL));
  for(int i = 0; i < n; i++){
    S[i] = rand() % (n*10);
  }

  //生成数组R
  int r = (int)floor(pow(n,0.75)); //计算R的大小
  int R[r];
  memcpy(R, S, r*sizeof(int));

  //对数组R进行排序
  QuickSort(R,0,r-1);

  //取两个标杆
  int d = R[(int)(0.5 * r - 0.05*sqrt(n))];
  int u = R[(int)(0.5 * r + 0.05*sqrt(n))];

  //取C，有优化空间
  int ld = count(d, S, 1);
  int lu = count(u, S, 0);
  int C[n-ld-lu];
  int c = 0;
  for(int i=0;i<n;i++){
    if(S[i]<=u&&S[i]>=d){
      C[c]=S[i];
      c++;
    }
  }
  int count = 0;
  end = clock();
  //判断中心值是否正确
  if (ld <= 0.5 * n && lu <= 0.5 * n && (n-ld-lu) <= 4*r)
  {
    start2 = clock();
    QuickSort(C,0,(n-ld-lu-1));
    end2 = clock();
    double shijian = ((double)(end2+end-start2-start)/1000);
    QuickSort(S,0,n-1);
    if(C[(int)floor(n/2)-ld+1]==S[n/2+1]){
      count=1;
    }
    return(shijian);
  }
  return ((double)(end-start)/1000);
 }

int main(){
  int N=1000;
  int count = 0;
  double shijian = 0.0;
  for(int i=0;i<N;i++){
    shijian+=LazySelect();
  }
  printf("The correct rating is %f\n",shijian/N);
  return (0);
}