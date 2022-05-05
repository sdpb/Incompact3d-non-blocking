#!/usr/bin/env python3
from sys import argv
var_to_send =  argv[1]
var_to_recv = argv[2]
dims = argv[3]

sbuf = f"sbuf{var_to_send}"
rbuf = f"rbuf{var_to_recv}"

print(f"DECLARATION LINE AND TO INSERT IN TRANSPOSE_START/END:\n\t {sbuf},{rbuf}")

# FOR ALLOCATE LINE
def allocate_line(buf,var):
    print(f"    allocate({buf}(", end="")
    for i in range(int(dims)):
        if i != 0:
            print(", ", end="")
        print(f"size({var},{i+1})", end="")
    print("))")


# FOR DEALLOCATE LINE
def deallocate_line(buf):
    print(f"    deallocate({buf})")


print("ALLOCATE LINES:")
allocate_line(sbuf, var_to_send)
allocate_line(rbuf, var_to_recv)

print("DEALLOCATE LINES:")
deallocate_line(sbuf)
deallocate_line(rbuf)
