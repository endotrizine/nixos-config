#!/usr/bin/env bash
# devtpl — быстрый выбор и инициализация шаблона из the-nix-way/dev-templates
#
# Использование:
#   ./devtpl.sh              -> интерактивный выбор (fzf, если есть, иначе select)
#   ./devtpl.sh rust         -> сразу инициализировать конкретный шаблон
#   ./devtpl.sh -n            -> создать новый проект в отдельной папке (спросит имя)
#   ./devtpl.sh -l            -> просто вывести список шаблонов
#
# Кидаешь файл куда угодно (например ~/.local/bin/devtpl), делаешь chmod +x и юзаешь.

set -euo pipefail

REPO="endotrizine/dev-templates"

TEMPLATES=(
  bun c-cpp clojure csharp cue deno dhall elixir elm empty gleam go hashi
  haskell haxe java jupyter kotlin latex lean4 nickel nim nix node ocaml
  odin opa php platformio powershell presenterm protobuf pulumi purescript
  python r ruby rust scala shell swi-prolog swift typst vlang zig
)

usage() {
  cat <<EOF
devtpl — выбор Nix flake dev-шаблона (${REPO})

  devtpl              интерактивный выбор шаблона в текущей папке
  devtpl <name>        сразу применить шаблон <name>
  devtpl -n [<name>]   создать новый проект в отдельной папке
  devtpl -l            вывести список доступных шаблонов
  devtpl -h            эта справка
EOF
}

list_templates() {
  printf '%s\n' "${TEMPLATES[@]}"
}

# fzf, если есть, иначе обычный select
pick_template() {
  if command -v fzf >/dev/null 2>&1; then
    printf '%s\n' "${TEMPLATES[@]}" | fzf --prompt="template> " --height=20 --border
  else
    echo "Выбери шаблон:" >&2
    select t in "${TEMPLATES[@]}"; do
      if [[ -n "${t:-}" ]]; then
        echo "$t"
        return
      fi
    done
  fi
}

apply_template() {
  local name="$1"
  local target_dir="${2:-.}"

  if ! printf '%s\n' "${TEMPLATES[@]}" | grep -qx "$name"; then
    echo "Неизвестный шаблон: $name" >&2
    echo "Доступные: ${TEMPLATES[*]}" >&2
    exit 1
  fi

  if ! command -v nix >/dev/null 2>&1; then
    echo "nix не найден в PATH. Установи Nix (с поддержкой flakes) и попробуй снова." >&2
    exit 1
  fi

  if [[ "$target_dir" == "." ]]; then
    echo "Инициализация шаблона '$name' в текущей директории..."
    nix flake init -t "github:${REPO}#${name}"
  else
    echo "Создание нового проекта '$target_dir' из шаблона '$name'..."
    nix flake new -t "github:${REPO}#${name}" "$target_dir"
  fi

  echo
  echo "Готово. Дальше:"
  echo "  cd $target_dir"
  echo "  direnv allow   # если стоит nix-direnv"
  echo "  # или"
  echo "  nix develop    # если direnv не установлен"
}

main() {
  local new_project=false
  local name=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help) usage; exit 0 ;;
      -l|--list) list_templates; exit 0 ;;
      -n|--new) new_project=true; shift ;;
      *) name="$1"; shift ;;
    esac
  done

  if [[ -z "$name" ]]; then
    name="$(pick_template)"
    [[ -z "$name" ]] && { echo "Ничего не выбрано." >&2; exit 1; }
  fi

  if $new_project; then
    read -rp "Имя папки для нового проекта [$name]: " dir
    dir="${dir:-$name}"
    apply_template "$name" "$dir"
  else
    apply_template "$name" "."
  fi
}

main "$@"
