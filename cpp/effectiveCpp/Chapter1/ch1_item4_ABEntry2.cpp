// fill main to initialize the defined classes
// here the class members are initialized with the initialization list - as a result a copy constructor is invoked with values provided with the list
// build in types must be initialized explicitly

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

ABEntry::ABEntry(const std::string& name, const std::string& address, const std::list<PhoneNumber>& phones): 
//			theName(name), 
//			theAddress(address), 
//			thePhones(phones), 
//			numTimesConsulted(0)
//{}
			theName(), 
			theAddress(), 
			thePhones(), 
			numTimesConsulted(0)
{}		
		
		

int main(){

	PhoneNumber phone = PhoneNumber("123 345 567");

	std::list<PhoneNumber> myPhones = {};

	ABEntry first = ABEntry("Mateo", "Munich", myPhones);

	int dummy;
	std::cin >> dummy;
	
	return 0;
}
