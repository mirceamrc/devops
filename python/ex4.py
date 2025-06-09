colegi = ["Ana", "Ionut", "Alin"]

input_coleg = input("introdu numele unui coleg: ")

if input_coleg.strip() and input_coleg not in colegi:
    print("Colegul nu exista!")
    colegi.append(input_coleg)

print(f"Lista colegilor: \n {colegi}")