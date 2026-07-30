{ ... }:
{
	services.keyd = {
  enable = true;
  keyboards = {
    # Создаем конфигурацию по умолчанию (для всех клавиатур)
    default = {
      # Символ "*" означает, что бинды применятся ко всем подключенным клавиатурам
      ids = [ "*" ]; 
      
      # Вот сюда переехали наши настройки
      settings = {
        main = {
          capslock = "overload(nav, esc)";
        };
        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          w = "C-right";
          b = "C-left";
          u = "home";
          o = "end";
        };
      };
    };
  };
};}

