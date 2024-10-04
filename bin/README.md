# AnKali APP

## /bin Directory

This directory simulates the path `/data/user/0/com.kalinr/bin`, which is primarily used for storing executable programs. In the case of AnKali, the bin directory also contains other executable programs. The `/bin directory` mainly holds the C source file `kali.c` related to the Kali Linux boot program and the Proot binary file `proot`.

- **kali.c**: Primarily used for the boot script of Kali Linux, written in the C programming language.

- **proot**: Used to simulate the Kali Linux environment, including functions such as mounting files. It is used in conjunction with the compiled binary file of `kali.c`.