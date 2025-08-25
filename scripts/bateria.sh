# Buscar el dispositivo de batería con upower
battery=$(upower -e | grep -i battery)

# Verificar si se encontró una batería
if [[ -z "$battery" ]]; then
    echo "Sin batería"
    exit 0
fi

# Obtener el porcentaje de carga
percentage=$(upower -i "$battery" | awk '/percentage/ {print $2}')

# Obtener el estado de carga
status=$(upower -i "$battery" | awk '/state/ {print $2}')

# Opcional: icono o símbolo
icon=""
case "$status" in
    charging) icon="⚡" ;;
    discharging) icon="🔋" ;;
    fully-charged) icon="🔌" ;;
esac

echo "Batería: $percentage $icon"
