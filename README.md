# Incompact3d-non-blocking for ISC22 - Team Épsilon

This readme serves as a documentation to understand our work done porting the Incompact3d application to use non-blocking communication.

# The problem

This app uses a lot of communication by using the group of functions "transpose\_\*\_to\_\*(src, dst)" that belong to the `decomp2d` module. The 
same module also provides their analogous functions that can be used to make such routines non-blocking. Said non-blocking functions divide the original
function into a "\_start" function and a "\_wait" function that starts the communication and the other that waits until such communication is finished.


# How we ported the code
Our work was guided by a human algorithm we developed to port each transpose communication. We proceed to explain it:

To use the non-blocking version, one has to identify the next use of the "dst" variables (the ones that receive the data from "src") and the last 
modification of the "src" variables, so that the start of the communication is made 

# Problems identified

* 
