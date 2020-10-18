#include <iostream>

using namespace std;

int array[] = {1, 2, 3, 4, 5};

void addToArray(int x);
template<typename T> 
inline void callForMax(const T& a, const T& b){
	addToArray(a > b ? a : b);
}

int main(){
	
	callForMax(10, 100);

	for (const auto &e : array){
		cout << e << endl;
	}
	return 0;
}

void addToArray(int x){
	for (auto & e : array){
		e = e + x;
	}
}
