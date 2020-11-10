#include <iostream>

template<typename T>
class NamedObject {
	public:
		NamedObject(const std::string& name, const T& value);  
		void showValues();
	private:
		NamedObject(const NamedObject&); // prevents using copy constructor
		NamedObject& operator=(const NamedObject&); // prevents using assignment operator
		std::string nameValue;
		T objectValue;
};

// NamedObject::showValue(){}
template<typename T>
NamedObject<T>::NamedObject(const std::string& name, const T& value) :
		nameValue(name), objectValue(value) {}

template<typename T>
void NamedObject<T>::showValues(){
	std::cout << nameValue << " "  << objectValue << std::endl;
}


using namespace std;
int main(){

	NamedObject<int> no1("Smallest Prime Number", 2);
	NamedObject<float> no2("Some Float Number", 2.55);
	NamedObject<float> no3(no2);  // uses copy constructor // doesn't compile
	NamedObject<int> no4("", 0);

	cout << "elo " <<  endl;
	no1.showValues();
	no2.showValues();
//	no3.showValues();

	no4=no1; // uses generated assignment operator // doesn't compile
	
//	no4.showValues();

	return 0;

}


