nixos-config/
├── flake.nix                          # + hostName в specialArgs/extraSpecialArgs
├── flake.lock
├── MIGRATION.md
│
├── lib/
│   └── import-dir.nix
│
├── pkgs/
│   └── flclashx/
│       ├── flake.nix
│       ├── flake.lock
│       └── pubspec.lock
│
├── system/                            # ВСЁ системное (NixOS), общее для всех хостов
│   ├── default.nix                     # авто-импорт modules/ + packages.nix + settings/
│   ├── packages.nix                     # системные пакеты, общие (что стоит)
│   ├── modules/                         # NixOS-опции по функции (как настроено)
│   │   ├── audio.nix
│   │   ├── desktop.nix
│   │   ├── graphics.nix
│   │   ├── kernel.nix
│   │   ├── keyd.nix
│   │   ├── locale.nix
│   │   ├── networking.nix
│   │   ├── nix-settings.nix
│   │   ├── services.nix
│   │   ├── users.nix
│   │   └── virtualization.nix           # → станет virtualization/ если разрастётся
│   └── settings/                        # системные конфиги программ/сервисов с raw-файлами
│       └── (пример: syncthing/, если появится общий для всех хостов)
│
├── home/                              # ВСЁ юзерское (Home Manager), общее для всех хостов
│   ├── default.nix                     # резолвер: для каждой ./settings/<name>
│   │                                    #   проверяет hosts/<hostName>/home/settings/<name>
│   │                                    #   если есть — импортирует его вместо дефолтного (полная замена папки)
│   ├── aliases.nix
│   ├── packages.nix                     # ВСЕ HM-пакеты, общие (что стоит)
│   ├── theme.nix
│   └── settings/                        # только конфиги программ (как настроено), не пакеты
│       ├── btop.nix
│       ├── direnv.nix
│       ├── discord.nix
│       ├── fish.nix
│       ├── flclashx.nix
│       ├── fuzzel.nix
│       ├── git.nix
│       ├── mpv.nix
│       ├── starship.nix
│       ├── kitty.nix                     # без raw-конфига — плоский файл
│       ├── neovim/                       # с raw-конфигом — папка
│       │   ├── default.nix
│       │   └── nvim.lua
│       ├── niri/
│       │   ├── default.nix
│       │   └── config.kdl                 # общий дефолт-конфиг niri
│       └── yazi/
│           ├── default.nix
│           └── yazi.toml
│
├── hosts/
│   ├── t14/
│   │   ├── default.nix                  # входная точка хоста: system + home imports
│   │   ├── hardware-configuration.nix
│   │   ├── system/                       # host-only системное, зеркало ./system
│   │   │   ├── packages.nix               # host-only системные пакеты
│   │   │   ├── modules/                   # host-only NixOS-опции (boot.nix, laptop.nix и т.п.)
│   │   │   │   ├── boot.nix
│   │   │   │   └── laptop.nix              # TLP, power и прочая t14-специфика
│   │   │   └── settings/                  # host-override системных настроек (полная замена)
│   │   │       └── syncthing/
│   │   │           └── default.nix
│   │   └── home/                         # host-only юзерское, зеркало ./home
│   │       ├── packages.nix               # HM-пакеты только для t14 (напр. prismlauncher)
│   │       └── settings/                  # host-override HM-программ (полная замена)
│   │           └── niri/
│   │               ├── default.nix
│   │               └── config.kdl          # ← полностью заменяет home/settings/niri для t14
│   │
│   └── desktop/
│       ├── default.nix
│       ├── hardware-configuration.nix
│       ├── system/
│       │   ├── packages.nix
│       │   ├── modules/
│       │   │   ├── boot.nix
│       │   │   └── nvidia.nix
│       │   └── settings/
│       └── home/
│           ├── packages.nix
│           └── settings/
