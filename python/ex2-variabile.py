age = 23 # integer
cost = 12.3 # Float
name = "Popescu Ioana" # String
is_valid = True # Boolean

print("Age is", age)

print( "Age is " + str(age))
print(f"Cost is {cost}")
print(f"Name is {name}")
print(f"is_valid {is_valid}")

complex_message = f"""
Age is {age}
Cost is {cost} and name is {name}
Is user valid {is_valid}
"""

print(complex_message)
