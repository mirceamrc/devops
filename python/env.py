import os

print(os.environ)

os.environ["NUME_CURSANT"] = "Andrei Mihai"

for key in os.environ:
    value = os.environ[key]    
    print(f"{key}={value}")

token = os.getenv("TOKEN","Nu exista")
print(token)

if "TOKEN" in os.environ:
    token = os.environ["TOKEN"]
    print(token)
else:
    print("Token nu a fost definit")