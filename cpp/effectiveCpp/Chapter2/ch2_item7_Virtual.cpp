// Item 7 : Declare destructors virtual in polymorphic base classes.

#include <iostream>
#include "TimeKeeper.h"

int main(){

	int dummy;
	std::cout << "Ktora godzina? 0 1 or 2" << std::endl;
	std::cin >> dummy;
	TimeKeeper* watch = TimeKeeper::Create(TimeKeeperType(dummy));
	(*watch).printTime();
	

	delete watch;
	watch = NULL;

	return 0;
}
