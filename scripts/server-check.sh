HOST="$1"

if [ -z "$HOST" ]; then
    echo "Uso: $0 <host>"
    exit 1
fi

if ping -c 1 -W 1 "$HOST" > /dev/null; then
    echo "🟢 $HOST"
else
    echo "🔴 $HOST"
fi
