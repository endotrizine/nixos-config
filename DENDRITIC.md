# Дендритик-паттерн в этом репозитории

Этот конфиг мигрирован с ручных `import-dir.nix`/`resolve-settings.nix` на
[дендритик-паттерн](https://github.com/mightyiam/dendritic) поверх
[flake-parts](https://flake.parts) и [import-tree](https://github.com/vic/import-tree).

Если коротко: **каждый `.nix` файл в `modules/` — это отдельный
flake-parts модуль**, который сам решает, к какой фиче/хосту он
относится. Ничего никуда руками не импортируется — новый файл
подхватывается автоматически.

## Зачем это было нужно

У старого подхода было два самописных файла:

- `lib/import-dir.nix` — руками собирал список `.nix` файлов в папке;
- `lib/resolve-settings.nix` — руками резолвил host-override, сравнивая
  имена файлов/папок.

Второй файл в итоге уронил `nix eval` на файле `.gitkeep`, потому что
не фильтровал не-`.nix` файлы. Это конкретный, реально произошедший
баг, из-за которого и затеяна вся миграция — не абстрактная
"чистота архитектуры", а вполне ощутимая поломка.

`import-tree` делает то же самое (рекурсивно собирает `.nix` файлы),
но это чужая, используемая сотнями людей библиотека — такого класса
багов там уже не будет.

## Как это устроено здесь

### `flake.nix`

Теперь ~40 строк: список `inputs` + один вызов `mkFlake`, который
импортирует `inputs.flake-parts.flakeModules.modules` (даёт опцию
`flake.modules`) и `(inputs.import-tree ./modules)` (подхватывает всё
дерево `modules/`). Всё.

### `modules/nixos/*.nix` и `modules/home/*.nix` — общие настройки

Каждый файл — это модуль, который **добавляет** что-то в
`flake.modules.nixos.common` (для NixOS) или
`flake.modules.homeManager.common` (для home-manager). Если два файла
пишут в один и тот же `common` — они автоматически мержатся Nix'овой
модульной системой (это встроенная семантика типа `deferredModule`,
не какая-то моя самоделка).

Пример (`modules/nixos/audio.nix`):

```nix
{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, ... }:
    {
      services.pipewire.enable = true;
      # ...
    };
}
```

**Хотите добавить новую общую настройку?** Просто создайте
`modules/nixos/что-то.nix` или `modules/home/что-то.nix` по этому же
шаблону. Ничего больше делать не нужно — `import-tree` подхватит файл
сам при следующем `nixos-rebuild`.

### `modules/hosts/<host>/*.nix` — специфика конкретной машины

Всё, что относится только к одному хосту, пишет в
`flake.modules.nixos."hosts/<host>"` или
`flake.modules.homeManager."hosts/<host>"` — по тому же принципу
автослияния. `system.stateVersion`, `hardware-configuration.nix`,
`boot.nix`, host-only пакеты — всё живёт в папке этого хоста.

### Host override — `lib.mkForce`, а не подмена файла

Раньше t14 **полностью заменял** папку `home/settings/niri/` на свою
(`resolveSettings` сравнивал имена и подставлял одну версию вместо
другой). Теперь то же самое делается штатным механизмом модульной
системы — `lib.mkForce`:

```nix
# modules/hosts/t14/niri/default.nix
{ ... }:
{
  flake.modules.homeManager."hosts/t14" =
    { lib, ... }:
    {
      xdg.configFile."niri/config.kdl".source = lib.mkForce ./config.kdl;
    };
}
```

`modules/home/niri/default.nix` (общий, desktop-flavored) задаёт
значение с обычным приоритетом, а этот файл его перебивает. Никакого
сопоставления имён файлов — явная, читаемая опция.

### `modules/wiring/hosts.nix` — точка сборки

Единственное место, где `flake.modules.nixos.*` /
`flake.modules.homeManager.*` превращаются в реальные
`nixosConfigurations.desktop` / `nixosConfigurations.t14`. У
flake-parts **нет** встроенной опции для этого шага — это осознанное
решение авторов паттерна (см. [обсуждение
#3](https://github.com/mightyiam/dendritic/discussions/3)), так что
этот файл — единственный "ручной" кусок во всём репозитории. Трогать
его нужно, только если добавляете новый хост или меняете, какие общие
модули куда подключены.

## Частые задачи

**Добавить новую общую программу (например, `alacritty`)**
→ создать `modules/home/alacritty.nix`, внутри
`flake.modules.homeManager.common = { programs.alacritty.enable = true; };`

**Добавить пакет только на t14**
→ дописать в `modules/hosts/t14/home-packages.nix` (или создать новый
файл рядом — не обязательно совать всё в один).

**Добавить третий хост**
→ создать `modules/hosts/<name>/default.nix` (по образцу
`hosts/t14/default.nix`) и добавить `<name> = mkHost "<name>";` в
`modules/wiring/hosts.nix`.

**Переопределить общую настройку для одного хоста**
→ `lib.mkForce` в host-модуле, как в примере с niri выше.

## Как проверить, что миграция ничего не сломала

```bash
cd ~/nixos-config
nix flake lock              # перегенерировать lock — добавлены inputs
nix flake check              # проверит, что всё вообще собирается
nixos-rebuild build --flake .#desktop   # или #t14, без switch — просто собрать
```

Если `nix flake check`/`build` проходят — можно `switch`. Если
где-то ошибка — она укажет конкретный файл и опцию, это гораздо
понятнее, чем `.gitkeep`-сюрприз из старой версии.

## Почитать про сам паттерн

- [mightyiam/dendritic](https://github.com/mightyiam/dendritic) —
  канонический README паттерна, оттуда все термины (`common`,
  anti-patterns, "module name proliferation" и т.д.)
- [Обсуждения в репозитории паттерна](https://github.com/mightyiam/dendritic/discussions) —
  живые вопросы от людей, мигрирующих свои конфиги, включая ровно
  такие же вопросы про host override, как решались здесь
- [vic/import-tree](https://github.com/vic/import-tree) — библиотека
  автоимпорта, которую использует этот репозиторий
- [flake-parts](https://flake.parts) и опция
  [`flake.modules`](https://flake.parts/options/flake-parts-modules.html) —
  механизм, на котором держится весь паттерн
- [Racha's Blog — "Clean NixOS: From configuration.nix to
  Dendritic"](https://blog.spacehey.com/entry?id=2107569) — понятный
  пошаговый тьюториал именно про переход с обычного конфига на
  дендритик (то, что мы только что проделали руками)
- [nix-book — The Dendritic Pattern with
  flake-parts](https://saylesss88.github.io/flakes/dendritic_flake_parts.html) —
  ещё один заход на объяснение с примерами
- Реальные конфиги для подсмотреть паттерны:
  [mightyiam/infra](https://github.com/mightyiam/infra),
  [GaetanLepage/nix-config](https://github.com/GaetanLepage/nix-config),
  [drupol/nixos-x260](https://github.com/drupol/nixos-x260)
- [Матрикс-комната #dendritic:matrix.org](https://matrix.to/#/#dendritic:matrix.org) —
  если появятся вопросы, туда же ходят люди, которые сам паттерн
  придумали и поддерживают
