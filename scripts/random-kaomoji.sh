kaomojis=("⁽⁽◝( • ω • )◜⁾⁾" "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧" "(｡♥‿♥｡)" "(づ｡◕‿‿◕｡)づ" "(≧◡≦)" "(*≧ω≦)" "(ﾉ≧∀≦)ﾉ" "(╯✧▽✧)╯" "°˖✧◝(⁰▿⁰)◜✧˖°"
  "(｡•́‿•̀｡)"
  "☆*:.｡.o(≧▽≦)o.｡.:*☆"
  "(⌒▽⌒)☆"
  "(o^▽^o)"
)

# Obtener un índice aleatorio
index=$((RANDOM % ${#kaomojis[@]}))

# Imprimir el kaomoji
echo "${kaomojis[$index]}"
