
if [ "$#" -ne 1 ]; then
	echo "Scriptul asteapta un paramteru"
	echo "A primit $#"
	exit 1
else
	echo "Am primit parametrul corecti."
fi

CALE_DIR=$1

echo " Ne apucam sa numaram cate fisire sunt in $CALE_DIR"

if [ -d '$CALE_DIR' ]; then
	NO_FILES=$(ls -al $CALE_DIR | wc -l)
	echo " Sunt $NO_FILES in directorul $CALE_DIR"
else
	echo "$CALE_DIR nu exista"
fi
