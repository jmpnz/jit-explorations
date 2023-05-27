static const int MAX_MEMORY = 30000;

void run(char op) {
    int TAPE[30000];
    int* ptr = &TAPE;
    switch (op) {
     case '<':
        ptr++;
        break;
     case '>':
        ptr--;
        break;
    }
}
