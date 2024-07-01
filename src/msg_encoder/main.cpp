#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char **argv) {
    cout << "Encoding: " << string(argv[1]) << ", into inc/stage1/msgencoder.asm as: " << string(argv[2]) << endl;

    ofstream msgencoder;

    msgencoder.open("inc/stage1/msgencoder.asm", ios_base::app);
    msgencoder << string(argv[2]) << ": db \'" << string(argv[1]) << "\', 0\n";
    msgencoder.close(); 

    return 0;
}
