{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      # Шрифт
      font-family = "JetBrains Mono Nerd Font";
      font-size = 11;

      # Курсор и звук
      cursor-style = "bar";
      cursor-style-blink = false;

      # Внешний вид и шелл
      window-padding-x = 5;
      window-padding-y = 5;
      command = "fish";

      # Не спрашивать при закрытии
      confirm-close-surface = false;

    };
  };
}
