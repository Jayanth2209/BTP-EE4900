import random

data_size = 1000

m1 = [int(random.random()*1000.00) for x in range(data_size)]
m2 = [int(random.random()*1000.00) for x in range(data_size)]
a = [int(random.random()*1000.00) for x in range(data_size)]

result = []

for i in range(data_size):
  result.append(m1[i]*m2[i] + a[i])

def print_arr(array_type, array_name, array_sz, pyarr):
    print("{} {}[{}] = ".format(array_type, array_name, array_sz))
    print("{")
    print(", ".join(map(str, pyarr)))
    print("};")


def print_scalar(scalar_type, scalar_name, pyscalar):
    print("{} {} = {};".format(scalar_type, scalar_name, pyscalar))

print("#define DATA_SIZE {}".format(data_size))

print_arr("int", "input_data_m1", "DATA_SIZE", m1)

print_arr("int", "input_data_m2", "DATA_SIZE", m2)

print_arr("int", "input_data_a", "DATA_SIZE", a)

print_arr("int", "verify_data", "DATA_SIZE", result)
