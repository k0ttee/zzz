#наиболее универсальная создавалка флешек - Balena Etcher
#только в винде - Rufus
#винда и линукс - Ventoy

#пролистать диски (включая синтезированне контейнеры)
diskutil list

#пролистать только физические диски (полезно когда дисков много)
diskutil list | sed '/synthesized/,/VM/d'

#форматирование с именем WINDA в Fat32, MBR (Legacy)
sudo diskutil eraseDisk FAT32 WINDA MBRFormat /dev/disk3

#скопировать всё из образа во флешку. Можно мышкой, можно терминалом
#слеш в конце первого пути обязателен!
cp -R путь_к_образу/ путь_к_флешке

cp -R /Volumes/windows-mounted-iso/ /Volumes/WINDA
