# PerlaOS

**PerlaOS** es un sistema operativo doméstico basado en **Debian Stable (Trixie)** con entorno **GNOME**, diseñado para que cualquier persona hispanohablante lo use sin conocimientos técnicos.

> Debian es la concha (sólida, estable, probada).  
> **PerlaOS** es la perla que se forma encima: pulida, elegante y fácil de usar.

---

## Principios

1. **Cero terminal obligatoria** — Todo se hace con clic.
2. **Español de serie** — Sistema, instalador, aplicaciones y ayuda en español.
3. **Estabilidad ante todo** — Base Debian Stable.
4. **Belleza cuidada** — Identidad visual propia (paleta perla violeta).
5. **Respeto al usuario** — Sin telemetría, sin publicidad, software libre.

---

## Características principales

- **Base:** Debian Stable (Trixie)
- **Escritorio:** GNOME
- **Instalador:** Calamares (en español)
- **Capa de comandos en español:** `instalar`, `copia`, `borra`, `ayuda`, `que_version`...
- **Tema visual propio** (Perla-purple)
- **Solo amd64** en la versión 1.0

### Comandos en español disponibles

| Comando | Descripción |
|---------|-------------|
| `instalar <paquete>` | Instala un programa |
| `desinstalar <paquete>` | Elimina un programa |
| `buscar <texto>` | Busca programas |
| `actualizar` | Actualiza el sistema |
| `limpia` | Limpia paquetes innecesarios |
| `entra <carpeta>` | Entra en una carpeta |
| `crea_carpeta <nombre>` | Crea una carpeta |
| `copia / mueve / borra` | Gestión de archivos |
| `lista` / `arbol` | Listar archivos |
| `que_version` | Muestra la versión de PerlaOS |
| `cuanto_espacio` | Espacio en disco |
| `red` | Estado de la red |
| `reinicia` / `apaga` | Control del equipo |
| `ayuda` o `perla` | Muestra la ayuda |

---

## Versión actual

- **1.0 "Nácar"** (en desarrollo)

---

## Estructura del proyecto

```
PerlaOS/
├── branding/                # Logo, tema, wallpapers
│   ├── logo/
│   └── theme/
├── calamares/               # Configuración del instalador
│   └── branding/perlaos/
├── docs/                    # Documentación y especificación
├── live-build/              # Configuración de live-build
│   ├── auto/
│   └── config/
│       ├── package-lists/
│       ├── includes.chroot/
│       └── hooks/
└── scripts/                 # Scripts de construcción
```

---

## Cómo construir la ISO (desarrollo)

```bash
# Requisitos (en Debian/Ubuntu)
sudo apt install live-build

# Clonar
git clone https://github.com/evimata96-stack/PerlaOS.git
cd PerlaOS

# Construir
cd live-build
sudo lb clean
sudo lb config
sudo lb build
```

La ISO se generará en el directorio `live-build/`.

> **Nota:** La construcción completa puede tardar entre 30 y 90 minutos.

---

## Estado del proyecto

| Fase | Contenido                                      | Estado       |
|------|------------------------------------------------|--------------|
| 0    | Definición                                     | ✅ Hecho     |
| 1    | Identidad visual (logo, paleta, tema)          | 🟡 Avanzado  |
| 2    | ISO funcional (live-build + Calamares + comandos) | 🟡 En curso |
| 3    | Utilidades propias (asistente, centro de ayuda)| ⬜ Pendiente |
| 4    | Pruebas beta                                   | ⬜ Pendiente |
| 5    | Lanzamiento 1.0 "Nácar"                        | ⬜ Pendiente |

---

## Identidad visual

**Paleta oficial:**

| Color              | Hex       | Uso                        |
|--------------------|-----------|----------------------------|
| Violeta profundo   | `#4B2E83` | Fondo principal            |
| Violeta medio      | `#7B4FA6` | Acentos secundarios        |
| Acento brillante   | `#C084FC` | Highlights, botones        |
| Blanco perlado     | `#F5F0FA` | Texto, fondos claros       |
| Oscuro base        | `#1A1025` | Fondos oscuros             |

---

## Licencia

Este proyecto se distribuye bajo los términos de la **GNU General Public License v3** (o posterior).  
La base del sistema es Debian, que tiene su propia política de licencias.

---

**Proyecto iniciado en noviembre 2026.**  
Hecho con ❤️ para la comunidad hispanohablante.
