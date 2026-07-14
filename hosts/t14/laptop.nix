{ pkgs, ...}:
{
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
	# Включаем службу сканера отпечатков пальцев
	services.fprintd.enable = true;

	# Настройки PAM для авторизации
	security.pam.services = {
  	# Вход в систему (консоль, дисплейные менеджеры)
  	login.fprintAuth = true;
  
  	# Команда sudo в терминале
  	sudo.fprintAuth = true;

  	# Если вы используете графический экран блокировки (например, GDM, SDDM, Swaylock, i3lock), 
  	# для него тоже можно включить, раскомментировав нужную строку ниже:
  	# gdm-fingerprint.fprintAuth = true;  # Для GNOME (GDM)
  	# kde.fprintAuth = true;              # Для KDE (SDDM)
  	# swaylock.fprintAuth = true;         # Для Sway
  };
	# Разрешаем несвободные прошивки (essential для ThinkPad)
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  # Включаем обновление микрокода процессора (тоже подтянет нужные драйверы)
}
