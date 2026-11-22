#!/bin/bash
# ============================================================
# PerlaOS - Capa de comandos en español
# Versión: 1.0 "Nácar"
# ============================================================
# Estos comandos NO sobrescriben los de Debian.
# Se añaden como funciones nuevas para facilitar el uso.
# ============================================================

# Colores
PERLA_VERDE='\033[0;32m'
PERLA_ROJO='\033[0;31m'
PERLA_AMARILLO='\033[1;33m'
PERLA_VIOLETA='\033[0;35m'
PERLA_CYAN='\033[0;36m'
PERLA_RESET='\033[0m'
PERLA_NEGRITA='\033[1m'

# Función de mensajes
_perla_ok()    { echo -e "${PERLA_VERDE}✓${PERLA_RESET} $1"; }
_perla_error() { echo -e "${PERLA_ROJO}✗${PERLA_RESET} $1"; }
_perla_aviso() { echo -e "${PERLA_AMARILLO}!${PERLA_RESET} $1"; }
_perla_info()  { echo -e "${PERLA_CYAN}→${PERLA_RESET} $1"; }

# ------------------------------------------------------------
# Gestión de software
# ------------------------------------------------------------

instalar() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar qué programa quieres instalar."
        echo "Ejemplo: instalar vlc"
        return 1
    fi
    _perla_info "Instalando $1..."
    if sudo apt install -y "$@"; then
        _perla_ok "¡$1 se instaló correctamente!"
    else
        _perla_error "No se pudo instalar $1."
        _perla_aviso "Prueba primero ejecutar: actualizar"
    fi
}

desinstalar() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar qué programa quieres desinstalar."
        echo "Ejemplo: desinstalar vlc"
        return 1
    fi
    _perla_info "Desinstalando $1..."
    if sudo apt remove -y "$@"; then
        _perla_ok "¡$1 se desinstaló correctamente!"
    else
        _perla_error "No se pudo desinstalar $1."
    fi
}

buscar() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar qué quieres buscar."
        echo "Ejemplo: buscar editor de video"
        return 1
    fi
    _perla_info "Buscando: $*"
    apt search "$@"
}

actualizar() {
    _perla_info "Actualizando la lista de programas..."
    sudo apt update
    _perla_info "Instalando actualizaciones disponibles..."
    if sudo apt upgrade -y; then
        _perla_ok "¡Sistema actualizado correctamente!"
    else
        _perla_error "Hubo un problema al actualizar."
    fi
}

limpia() {
    _perla_info "Limpiando paquetes que ya no se necesitan..."
    sudo apt autoremove -y
    sudo apt clean
    _perla_ok "¡Limpieza terminada!"
}

# ------------------------------------------------------------
# Archivos y carpetas
# ------------------------------------------------------------

entra() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar a qué carpeta quieres entrar."
        echo "Ejemplo: entra Documentos"
        return 1
    fi
    if cd "$1" 2>/dev/null; then
        _perla_ok "Ahora estás en: $(pwd)"
    else
        _perla_error "No existe la carpeta '$1'"
    fi
}

crea_carpeta() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar el nombre de la carpeta."
        echo "Ejemplo: crea_carpeta Fotos"
        return 1
    fi
    if mkdir -p "$1"; then
        _perla_ok "Carpeta '$1' creada."
    else
        _perla_error "No se pudo crear la carpeta '$1'"
    fi
}

copia() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        _perla_error "Uso: copia <origen> <destino>"
        echo "Ejemplo: copia tesis.odt /media/usb"
        return 1
    fi
    if cp -v "$1" "$2"; then
        _perla_ok "Copiado correctamente."
    else
        _perla_error "No se pudo copiar."
    fi
}

mueve() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        _perla_error "Uso: mueve <origen> <destino>"
        echo "Ejemplo: mueve *.jpg Fotos/"
        return 1
    fi
    if mv -v "$1" "$2"; then
        _perla_ok "Movido correctamente."
    else
        _perla_error "No se pudo mover."
    fi
}

borra() {
    if [ -z "$1" ]; then
        _perla_error "Debes indicar qué quieres borrar."
        echo "Ejemplo: borra viejo.odt"
        return 1
    fi

    # Protección crítica
    case "$1" in
        /|/bin|/boot|/dev|/etc|/lib|/lib64|/proc|/root|/run|/sbin|/sys|/usr|/var)
            _perla_error "¡Operación peligrosa bloqueada! No se puede borrar '$1'"
            return 1
            ;;
    esac

    echo -e "${PERLA_AMARILLO}¿Estás seguro de que quieres borrar '$1'? (s/N)${PERLA_RESET}"
    read -r respuesta
    if [[ "$respuesta" =~ ^[sS]$ ]]; then
        if rm -rfv "$1"; then
            _perla_ok "Borrado correctamente."
        else
            _perla_error "No se pudo borrar."
        fi
    else
        _perla_aviso "Operación cancelada."
    fi
}

lista() {
    if command -v eza &>/dev/null; then
        eza -lh --icons --group-directories-first "$@"
    elif command -v lsd &>/dev/null; then
        lsd -lh --group-directories-first "$@"
    else
        ls -lh --color=auto --group-directories-first "$@"
    fi
}

arbol() {
    if command -v tree &>/dev/null; then
        tree -C -L 3 "$@"
    else
        _perla_aviso "El comando 'tree' no está instalado. Mostrando alternativa..."
        find "${1:-.}" -maxdepth 3 -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
    fi
}

donde_estoy() {
    echo -e "${PERLA_VIOLETA}${PERLA_NEGRITA}$(pwd)${PERLA_RESET}"
}

# ------------------------------------------------------------
# Sistema
# ------------------------------------------------------------

que_version() {
    echo -e "${PERLA_VIOLETA}${PERLA_NEGRITA}PerlaOS 1.0 \"Nácar\"${PERLA_RESET}"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "Base: $PRETTY_NAME"
    fi
    echo "Núcleo: $(uname -r)"
    echo "Arquitectura: $(uname -m)"
}

cuanto_espacio() {
    echo -e "${PERLA_NEGRITA}Espacio en disco:${PERLA_RESET}"
    df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs | grep -E '^/dev|Sistema'
}

que_procesos() {
    echo -e "${PERLA_NEGRITA}Resumen del sistema:${PERLA_RESET}"
    echo "Carga: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Memoria:"
    free -h | awk '/^Mem:/ {print "  Usada: "$3" / Total: "$2}'
    echo ""
    echo "Procesos que más CPU usan:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

red() {
    echo -e "${PERLA_NEGRITA}Estado de la red:${PERLA_RESET}"
    if command -v nmcli &>/dev/null; then
        nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device status | while IFS=: read -r dev tipo estado conn; do
            if [ "$estado" = "connected" ]; then
                echo -e "  ${PERLA_VERDE}●${PERLA_RESET} $dev ($tipo) → $conn"
            else
                echo -e "  ${PERLA_ROJO}○${PERLA_RESET} $dev ($tipo) → $estado"
            fi
        done
    else
        ip -br addr show
    fi
}

reinicia() {
    echo -e "${PERLA_AMARILLO}¿Seguro que quieres reiniciar el equipo? (s/N)${PERLA_RESET}"
    read -r respuesta
    if [[ "$respuesta" =~ ^[sS]$ ]]; then
        _perla_info "Reiniciando..."
        systemctl reboot
    else
        _perla_aviso "Reinicio cancelado."
    fi
}

apaga() {
    echo -e "${PERLA_AMARILLO}¿Seguro que quieres apagar el equipo? (s/N)${PERLA_RESET}"
    read -r respuesta
    if [[ "$respuesta" =~ ^[sS]$ ]]; then
        _perla_info "Apagando..."
        systemctl poweroff
    else
        _perla_aviso "Apagado cancelado."
    fi
}

# ------------------------------------------------------------
# Ayuda
# ------------------------------------------------------------

ayuda() {
    if [ -n "$1" ]; then
        case "$1" in
            instalar)     echo "instalar <paquete>  → Instala un programa (ej: instalar vlc)" ;;
            desinstalar)  echo "desinstalar <paquete> → Elimina un programa" ;;
            buscar)       echo "buscar <texto>      → Busca programas disponibles" ;;
            actualizar)   echo "actualizar          → Actualiza el sistema" ;;
            limpia)       echo "limpia              → Limpia paquetes innecesarios" ;;
            entra)        echo "entra <carpeta>     → Entra en una carpeta" ;;
            crea_carpeta) echo "crea_carpeta <nombre> → Crea una carpeta" ;;
            copia)        echo "copia <origen> <destino> → Copia archivos" ;;
            mueve)        echo "mueve <origen> <destino> → Mueve archivos" ;;
            borra)        echo "borra <ruta>        → Borra (pide confirmación)" ;;
            lista)        echo "lista               → Lista archivos de forma legible" ;;
            arbol)        echo "arbol [carpeta]     → Muestra el árbol de carpetas" ;;
            donde_estoy)  echo "donde_estoy         → Muestra la carpeta actual" ;;
            que_version)  echo "que_version         → Muestra la versión de PerlaOS" ;;
            cuanto_espacio) echo "cuanto_espacio    → Espacio libre en disco" ;;
            que_procesos) echo "que_procesos        → Resumen de carga y procesos" ;;
            red)          echo "red                 → Estado de la conexión de red" ;;
            reinicia)     echo "reinicia            → Reinicia el equipo (pide confirmación)" ;;
            apaga)        echo "apaga               → Apaga el equipo (pide confirmación)" ;;
            *)            _perla_error "No conozco el comando '$1'. Escribe solo 'ayuda' para ver todos." ;;
        esac
        return
    fi

    echo -e "${PERLA_VIOLETA}${PERLA_NEGRITA}"
    echo "╔══════════════════════════════════════════════════╗"
    echo "║           Comandos de PerlaOS                    ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo -e "${PERLA_RESET}"
    echo -e "${PERLA_NEGRITA}Gestión de software${PERLA_RESET}"
    echo "  instalar <paquete>     Instala un programa"
    echo "  desinstalar <paquete>  Elimina un programa"
    echo "  buscar <texto>         Busca programas"
    echo "  actualizar             Actualiza el sistema"
    echo "  limpia                 Limpia archivos innecesarios"
    echo ""
    echo -e "${PERLA_NEGRITA}Archivos y carpetas${PERLA_RESET}"
    echo "  entra <carpeta>        Entra en una carpeta"
    echo "  crea_carpeta <nombre>  Crea una carpeta"
    echo "  copia <origen> <dest>  Copia archivos"
    echo "  mueve <origen> <dest>  Mueve archivos"
    echo "  borra <ruta>           Borra (pide confirmación)"
    echo "  lista                  Lista archivos"
    echo "  arbol [carpeta]        Árbol de carpetas"
    echo "  donde_estoy            Muestra carpeta actual"
    echo ""
    echo -e "${PERLA_NEGRITA}Sistema${PERLA_RESET}"
    echo "  que_version            Versión de PerlaOS"
    echo "  cuanto_espacio         Espacio en disco"
    echo "  que_procesos           Carga del sistema"
    echo "  red                    Estado de la red"
    echo "  reinicia               Reinicia el equipo"
    echo "  apaga                  Apaga el equipo"
    echo ""
    echo -e "${PERLA_NEGRITA}Ayuda${PERLA_RESET}"
    echo "  ayuda                  Muestra esta ayuda"
    echo "  ayuda <comando>        Explica un comando"
    echo "  perla                  Igual que 'ayuda'"
    echo ""
    echo -e "Escribe ${PERLA_CYAN}ayuda <comando>${PERLA_RESET} para más detalles."
}

perla() {
    ayuda "$@"
}

# Mensaje de bienvenida al abrir terminal (solo si es interactivo)
if [[ $- == *i* ]] && [ -z "$PERLA_NO_WELCOME" ]; then
    echo -e "${PERLA_VIOLETA}PerlaOS${PERLA_RESET} — Escribe ${PERLA_CYAN}ayuda${PERLA_RESET} o ${PERLA_CYAN}perla${PERLA_RESET} para ver los comandos en español."
fi
