import sys
import os

if len(sys.argv) != 2:
    print("Ai cchemat scriptul gesit!")
    print(f"Exemplu: python3 {sys.argv[0]} ls")
    sys.exit(1)
else:
    scriptul_cautat = sys.argv[1]

print(f"Cautam locatia {scriptul_cautat}")

VAR_PATH= os.getenv("PATH")
lista_cai = VAR_PATH.split(":")

for cale_din_path in lista_cai:
    if os.path.isdir(cale_din_path):
        calea_completa = cale_din_path + "/" + scriptul_cautat
        if os.path.isfile(calea_completa):
            print(f"Cautam in {calea_completa}")
