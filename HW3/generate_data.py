"""
Ahmed Abdulkareem
05/08/2016
ECE 351 HW3
This script is used to generate test patterns
"""
import argparse
import sys 


def rotate(args):
    if args.left:
        rotate_generate("left")
    elif args.right:
        rotate_generate("right")
    else:
        rotate_generate("left")
        rotate_generate("right")


def shift(args):
    if args.left:
        shift_generate("left")
    elif args.right:
        shift_generate("right")
    else:
        shift_generate("left")
        shift_generate("right")


def arithmetic(args):
    if args.adder:
        adder_generate(args)
    elif args.sub:
        sub_generate(args)
    else:
        adder_generate(args)
        sub_generate(args)


def logical_generate(op = "OR"):

    logical_list = []

    for A in range(0, 256, 85):
        for B in range(0, 256, 85):
            logical_list.append(A)
            logical_list.append(B)
            if direction == "OR":
                logical_list.append(A | B)
            elif direction == "AND":
                logical_list.append(A & B)
            elif direction == "NAND":
                logical_list.append(~(A & B))


def shift_generate(direction = "left"):
    
    shift_list = []

    # generate inputs 
    for A in range(0, 256, 15):
        for B in range(0, 14):
            shift_list.append(A)
            shift_list.append(B)
            if B < 9:
                if direction == "left":
                    shift_list.append(A << B)
                elif direction == "right":
                    shift_list.append(A >> B)
            else:
                shift_list.append(0)

    dump_data(direction + "_shift_data.txt", shift_list)


def rotate_generate(direction = "left"):

    shift_list = []

    # this rotation code is from:
    # http://www.falatic.com/index.php/108/python-and-bitwise-rotation
    rotate_left = lambda val, r_bits, max_bits: \
        (val << r_bits%max_bits) & (2**max_bits-1) | ((val & (2**max_bits-1)) >> (max_bits-(r_bits%max_bits)))

    rotate_right = ror = lambda val, r_bits, max_bits: \
        ((val & (2**max_bits-1)) >> r_bits%max_bits) | (val << (max_bits-(r_bits%max_bits)) & (2**max_bits-1))

    # generate inputs
    for A in range(0, 256, 15):
        for B in range(0, 14):
            shift_list.append(A)
            shift_list.append(B)
            if B < 9:
                if direction == "left":
                    shift_list.append(rotate_left(A, B, 8));
                elif direction == "right":
                    shift_list.append(rotate_right(A, B, 8));
            else:
                shift_list.append(0)

    # dump data
    dump_data(direction + "_rotate_data.txt", shift_list)


def sub_generate(args):
    
    sub_list = []

    # generate inputs where A > B
    for A in range(255, -1, -15):
        B = 0
        while B <= A:
            sub_list.append(A)
            sub_list.append(B)
            sub_list.append(A - B)
            B += 15

    print("Length of data where A > B:", len(sub_list))
    
    # generate inputs where A < B
    for A in range(0, 256, 15):
        B = 255
        while B > A:
            sub_list.append(A)
            sub_list.append(B)
            sub_list.append(A - B)
            B -= 15
    
    dump_data("sub_data.txt", sub_list)
    print("Length of data combined:", len(sub_list))


def adder_generate(args):

    adder_list = []

    # generate inputs and right outputs as A B result
    for A in range(0, 256, 15):
        for B in range(0, 256, 15):
            adder_list.append(A)
            adder_list.append(B)
            adder_list.append(A + B)

    dump_data("adder_data.txt", adder_list)
    print("Length of data: ", len(adder_list))

def dump_data(fname, data):
    """ 
    this function dumps data into file named fname
    data: list
    this will dump data in hex format. Assuming list has integers
    """

    try:
        with open(fname, "w") as afile:
            for item in data:
                hex_num = hex(item).replace("0x", "")
                afile.write(hex_num + " ") 
    except:
        print("couldn't open file %s in current directory" % fname)
    

# setting up arguments and parsing them
parser = argparse.ArgumentParser()
sub_parser = parser.add_subparsers()

# arithmetic parser
arithmetic_parser = sub_parser.add_parser("arithmetic")
arithmetic_parser.add_argument("-adder", help = "generate data for adder unit", action = "store_true")
arithmetic_parser.add_argument("-sub", help = "generate data for subtractor unit", action = "store_true")
arithmetic_parser.set_defaults(func = arithmetic)

# shift parser
shift_parser = sub_parser.add_parser("shift")
shift_parser.add_argument("-left", help = "generate data for left shifts", action = "store_true")
shift_parser.add_argument("-right", help = "generate data for right shifts", action = "store_true")
shift_parser.set_defaults(func = shift)

# rotate parser
rotate_parser = sub_parser.add_parser("rotate")
rotate_parser.add_argument("-left", help = "generate data for rotate left", action = "store_true")
rotate_parser.add_argument("-right", help = "generate data for rotate right", action = "store_true")
rotate_parser.set_defaults(func = rotate)


if __name__ == "__main__":
   
    if len(sys.argv) < 2:
        print("Please provide enough arguments, use --help for info")
        exit(0)
    cmd = parser.parse_args()
    cmd.func(cmd)
    
