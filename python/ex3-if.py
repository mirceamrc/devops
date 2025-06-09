import sys

user_admin = "gigi"
pass_admin = "parola"

user_input = input("Introdu userul ")
pass_input = input("introdu parola ")

if user_admin == user_input and pass_admin == pass_input:
    print(f"Esti logat!")
else:
    print(f"Mai incearca!")
    sys.exit(1)

print("Bye bye")