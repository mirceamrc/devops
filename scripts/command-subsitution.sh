CATLE_DIRECTOR=${1:-"/tmp"}

NO_SCRIPTS=$(ls -al $CALE_DIRECTOR | wc -l)
DATA_EXECUTIE=$(date)

echo "Avem $NO_SCRIPTS in directorul $CALE_DIRECTOR"

echo "Am rulat scriptul la data $DATA_EXECUTIE"
