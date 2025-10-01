import json
import os
import sys

if os.path.isfile("/tmp/bazadedate.json"):
    with open("/tmp/bazadedate.json", mode="r") as file:
        detalii_cursant = json.load(file)
else:
    nume_user=input("Enter nume user: ")
    varsta_user=input("Enter varsta user: ")
    parola_user=input("Enter parola user: ")

    detalii_cursant = {"nume_user": nume_user,
                       "varsta_user": varsta_user,
                       "parola_user": parola_user
                       }
    
if "is_blocked" in detalii_cursant and detalii_cursant["is_blocked"]:
    print (f"Userul {detalii_cursant['nume_user']} este blocat")
    sys.exit(1)


for index in range (1,4):
    parola_user=input("Enter parola user: ")
    if parola_user == detalii_cursant["parola_user"]:
        print("Esti logat")
        break
    else:
        print("Parola gresita")
        if index == 3:
            print("te-am blocat")
            detalii_cursant["is_blocked"] = True
with open("/tmp/bazadedate.json", mode="w") as file:
    json.dump(detalii_cursant, file, indent=4)