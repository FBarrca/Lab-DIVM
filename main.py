#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: Francisco Barragán Castro

# This code creates the tensors needed to compute the direct cinematics of a robot

from math import *
from linalg import *
# from sympy import *

# Function that creates the direct cinematics of a robot


def CinemDirecta(Theta, D, A, Alpha):
    a = Matrix([[cos(Theta), -sin(Theta)*cos(Alpha), sin(Theta)*sin(Alpha), A*cos(Theta)],
                [sin(Theta), cos(Theta)*cos(Alpha), -
                 cos(Theta)*sin(Alpha), A*sin(Theta)],
                [0, sin(Alpha), cos(Alpha), D],
                [0, 0, 0, 1]])
    # return a
    return a

# Leaves theta as a parameter  returns a matrix of strings
    def CinemDirectaSinTheta(D, A, Alpha):


D = float(sys.argv[0])
A = float(sys.argv[1])
Alpha = float(sys.argv[2])
a = matrix([[1, -cos(radians(Alpha)), sin(radians(Alpha)), A],
            [0, cos(radians(Alpha)), sin(radians(Alpha)), A],
            [0, sin(radians(Alpha)), cos(radians(Alpha)), D],
            [0, 0, 0, 1]])
# Matrix with the strings of the theta components
thetas = [["cos(theta)", "cos(theta)", "sin(theta)", "cos(theta)"],
          ["sin(theta)", "cos(theta)", "cos(theta)", "sin(theta)"],
          [0, "sin(theta)", "cos(theta)", 0],
          [0, 0, 0, "1"]]

print("______________________________________________")
for i in range(0, 4):
    for j in range(0, 4):
        
        if a[i][j] == 1:
            if thetas[i][j] == 0:
                print("1", end="")

        else:
            a[i][j] = str(round(a[i][j], 2))
            print(a[i][j], end=" ")
        if (float(a[i][j]) != 1 or float(a[i][j]) != 0) and thetas[i][j] != 0:
            print("*", end="")
        if thetas[i][j] != 0:
            if float(a[i][j]) != 0:
                print(" "+thetas[i][j], end=" ")
        print("]", end="")

    print("", end="\n")


print("[cos(T), -sin(T)* %.2f, sin(T)* %.2f, %.2f *cos(T)]," %
      (cos(float(sys.argv[2])), sin(float(sys.argv[2])), float(sys.argv[1])))
print("[sin(T), cos(T)* %.2f, -cos(T)* %.2f, %.2f *sin(T)]," %
      (cos(float(sys.argv[2])), sin(float(sys.argv[2])), float(sys.argv[1])))
print("[0, %.2f, %.2f, %.2f]," %
      (sin(float(sys.argv[2])), cos(float(sys.argv[2])), float(sys.argv[0])))
print("[0, 0, 0, 1]")


def main():
    """ Main program """
    print(CinemDirecta(3, 4, 5, 2))
    # Code goes over here.
    return 0


if __name__ == "__main__":
    main()
