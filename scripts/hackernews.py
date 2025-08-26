import xml.etree.ElementTree as ET
import random

# Leer el archivo
with open('/tmp/hn.xml', 'r', encoding='utf-8') as file:
    contenido = file.read()

# Parsear el contenido
root = ET.fromstring(contenido)

# Buscar todos los ítems (noticias) dentro de <channel>
items = root.find('channel').findall('item')

# Extraer todos los títulos
titulos = [item.find('title').text for item in items]

# Elegir uno al azar
titulo_aleatorio = random.choice(titulos)

print(titulo_aleatorio)
