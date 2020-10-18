#include <iostream>

using namespace std;

int array[] = {1, 2, 3, 4, 5};

void addToArray(int x);


int main(){

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
