#include <stdio.h>
#include <string.h>
/*
- steps:
  - read the file into the buffer:
https://stackoverflow.com/questions/51224682/read-file-byte-by-byte-using-c
  - iterate over the buffer, xorring the bits, then covert to little endian
  - store the contents into the comm_packet structure
*/

struct comm_packet {            // Offset
    char Id[4];                 //   0
    char NodeName[8];           //   4
    int NodeNumber;             //  12
    int tx_packet_nbr;          //  16
    int rx_packet_nbr;          //  20
    int track_object_nbr;       //  24
    int track_object_x_pos;     //  28
    int track_object_y_pos;     //  32
    int track_object_z_pos;     //  36
    int track_object_velocity;  //  40
    int status_code;            //  44
    unsigned char msg_length;   //  48
    char status_msg[128];       //  49
};

int main() {
    unsigned char key[9] = {0x36, 0x13, 0x92, 0xa5, 0x5a,
                            0x27, 0xf3, 0x00, 0x32};
    // // struct comm_packet packet;
    FILE *fp;
    fp = fopen("../inputs/packet", "rb");
    char buffer[180];
    fread(&buffer, 1, 180, fp);
    fclose(fp);
    printf("\n");
    int index = 0;
    for (int i = 0; i < 180; ++i) {
        buffer[i] = buffer[i] ^ key[index % 9];
        index++;
    }
    for (int i = 0; i < 180; ++i) {
        printf("%c", buffer[i]);
    }
    printf("\n");
    return 0;
}
