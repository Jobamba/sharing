// fill main to initialize the defined classes
// here the class members aren't initialiyed in the constructor - they are assigned


#include <iostream>
#include <string>
#include <list>

class PhoneNumber { 
	std::string thisphone;

	public: PhoneNumber(std::string phone){
		thisphone = phone;
	}

};

class ABEntry {
// ABEntry = “Address Book Entry”
	public:
		ABEntry(const std::string& name, const std::string& address, const std::list<PhoneNumber>& phones);
	private:
		std::string theName;
		std::string theAddress;
		std::list<PhoneNumber> thePhones;
		int numTimesConsulted;
};

ABEntry::ABEntry(const std::string& name, const std::string& address, const std::list<PhoneNumber>& phones)
{
	theName = name;
	// these are all assignments ,
	theAddress = address;
	// not initializations
	thePhones = phones;
	numTimesConsulted = 0;
}

int main(){

	PhoneNumber phone = PhoneNumber("123 345 567");

	std::list<PhoneNumber> myPhones = {};

	ABEntry first = ABEntry("Mateo", "Munich", myPhones);

	int dummy;
	std::cin >> dummy;
	
	return 0;
}
