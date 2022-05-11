# Incompact3d-non-blocking for ISC22 - Team Épsilon

This readme serves as a documentation to understand our work done porting the Incompact3d application to use non-blocking communication.

# The problem

This app uses a lot of communication by using the group of routines "transpose\_\*\_to\_\*(src, dst)" that belong to the `decomp2d` module. The 
same module also provides their analogous functions that can be used to make such routines non-blocking. Said non-blocking functions divide the original
function into a "\_start" function and a "\_wait" function that starts the communication in the background and waits until such communication is finished, respectively.


# How we ported the code
Our work was guided by a human algorithm we developed to port each transpose communication. We proceed to explain it:

1. Identify the last time the src variable was updated, and put the \_start function just after it.
2. Identify the next time the dst variable is going to be used, and put the \_wait function just before it.
3. Declare the buffer variables (sbuf and rbuf) at the beginning of each subroutine as allocatable, and having the same number of dimensions as its corresponding original variable (see the example below to understand it fully). E.g. if there is a src variable named "ta1" its send buffer variable will be "sbufta1".
4. Allocate the buffer variables so that they have the same size on each dimension as its corresponding original variable.
5. Add the deallocate lines at the end of the subroutine.

# Example



# Problems identified

* When one has too many communications on the background, they are not optimal and can be degreading for the performance. One should be aware of the quantity of communications going on the background.
