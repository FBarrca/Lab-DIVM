# Computes the coordinate system of a robot arm using the direct kinematics

import cas
import math
import sys

# Function that creates the direct cinematics of a robot
def CinemDirecta(Theta, D, A, Alpha):
    a = cas.eval_expr("[[cos(Theta), -sin(Theta)*cos(Alpha), sin(Theta)*sin(Alpha), A*cos(Theta)]")
    b = cas.eval_expr("[sin(Theta), cos(Theta)*cos(Alpha), -cos(Theta)*sin(Alpha), A*sin(Theta)]")
    c = cas.eval_expr("[0, sin(Alpha), cos(Alpha), D]")
    d = cas.eval_expr("[0, 0, 0, 1]]")
    # return a
    if a == 1:
        return b
    else :
        return c
    return a

def main():
    Theta = sys.argv[0]
    D = sys.argv[1]
    A = sys.argv[2]
    Alpha = sys.argv[3]
    # Leaves theta as a parameter  returns a matrix of strings
    return  CinemDirecta(Theta, D, A, Alpha)
    
# main
if __name__ == "__main__":
    main()



hpprime.eval("42 R")