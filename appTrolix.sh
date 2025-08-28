#!/bin/bash

# Couleurs
RED='\033[0;31m'
VIOLET='\033[0;35m'
NC='\033[0m'

# Fonction pour afficher le logo Trolix (même style, même couleurs)
show_logo() {
    echo -e "${RED}████████╗██████╗  ██████╗ ██╗     ██╗██╗  ██╗${NC}"
    echo -e "${VIOLET}╚══██╔══╝██╔══██╗██╔═══██╗██║     ██║╚██╗██╔╝${NC}"
    echo -e "${RED}   ██║   ██████╔╝██║   ██║██║     ██║ ╚███╔╝ ${NC}"
    echo -e "${VIOLET}   ██║   ██╔══██╗██║   ██║██║     ██║ ██╔██╗ ${NC}"
    echo -e "${RED}   ██║   ██║  ██║╚██████╔╝███████╗██║██╔╝ ██╗${NC}"
    echo -e "${VIOLET}   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝${NC}"
}

# Fonction de chargement avec barre + pourcentage
loading_animation() {
    total_steps=15
    bar_width=20

    for ((i = 1; i <= total_steps; i++)); do
        percent=$(( i * 100 / total_steps ))
        filled=$(( i * bar_width / total_steps ))
        empty=$(( bar_width - filled ))
        bar=$(printf "%0.s=" $(seq 1 $filled))
        space=$(printf "%0.s " $(seq 1 $empty))
        printf "\r${VIOLET}Chargement [${RED}%s${NC}${space}${VIOLET}] %s%%%s" "$bar" "$percent" "$NC"
        sleep 1
    done
    echo -e "\n"
}

# Vérifier/créer le dossier ~/trolixAPP
[ ! -d "$HOME/trolixAPP" ] && mkdir -p "$HOME/trolixAPP"

# Fonction pour afficher le menu
show_menu() {
    clear
    show_logo
    echo ""
    echo -e "${VIOLET}=========== ${RED}MENU PRINCIPAL ${VIOLET}==========${NC}"
    echo -e "${VIOLET}[01]${NC} ${RED}Lancer trolixVE${NC}"
    echo -e "${VIOLET}[02]${NC} ${RED}Module à venir${NC}"
    echo -e "${VIOLET}[99]${NC} ${RED}Quitter${NC}"
    echo -e "${VIOLET}==================================${NC}"
    echo ""
    read -p "Choix > " choix
    handle_choice "$choix"
}

# Fonction pour gérer le choix utilisateur
handle_choice() {
    case "$1" in
        01)
            echo -e "\n${RED}[Démarrage de trolixVE...]${NC}"
            loading_animation
            # cd dans le dossier de l'app et lance start.sh
            if [ -d "$HOME/trolixAPP/trolixVE" ] && [ -x "$HOME/trolixAPP/trolixVE/start.sh" ]; then
                cd "$HOME/trolixAPP/trolixVE"
                bash start.sh
            else
                echo -e "${RED}[Erreur : dossier ou script start.sh introuvable dans trolixVE]${NC}"
                sleep 2
            fi
            ;;
        02)
            echo -e "\n${RED}[Module en développement...]${NC}"
            loading_animation
            ;;
        99)
            echo -e "\n${RED}[Sortie de TrolixAPP...]${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Choix invalide${NC}"
            sleep 1
            ;;
    esac
    show_menu
}

# Lancer le menu principal
show_menu
