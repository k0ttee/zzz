############################
# снос хлама с диска macOS #
############################




#скринсейверы (262,3 mb)
sudo rm -rf /Library/Screen\ Savers/Default\ Collections/*

#обои (691,9 mb)
sudo rm -rf /Library/Desktop\ Pictures/*

#иконки пользователя (21,4 mb)
sudo rm -rf /Library/User\ Pictures/*

#сетевая утилита (1,6 mb давно устарела и не запускается)
sudo rm -rf /System/Library/CoreServices/Applications/Network\ Utility.app

#DVD плеер (2,7 mb)
sudo rm -rf /System/Library/CoreServices/Applications/DVD\ Player.app

#игры (2,8 mb)
sudo rm -rf /System/Library/CoreServices/Games.app




#голоса для синтеза речи (551,7 mb)
sudo rm -rf /System/Library/Speech/Voices




#у меня нет iOS устройств (287,9 mb)
rm -rf /System/iOSSupport




#видео (сколько весят ролики)
du -sh /System/Library/Compositions/*

#снос роликов

#8,1 mb
sudo rm /System/Library/Compositions/Eiffel Tower.mov
#20 mb
sudo rm /System/Library/Compositions/Fish.mov
#6,4 mb
sudo rm /System/Library/Compositions/Rollercoaster.mov
#2,6 mb
sudo rm /System/Library/Compositions/Sunset.mov
#3,6 mb
sudo rm /System/Library/Compositions/Yosemite.mov




#кексты к устройствам, которых нет на этой машине
cd /System/Library/Extensions/
#на мой взгляд, сидя на современном железе, можно смело снести кексты древних видеокарт




#шрифты
cd /Library/Fonts/

#на мой взгляд, можно снести: индусский, израильский, арабский
rm Al\ Nile.ttc
rm Al\ Tarikh.ttc
rm AlBayan.ttc
rm Baghdad.ttc
rm Beirut.ttc
rm Corsiva.ttc
rm Damascus.ttc
rm DecoTypeNaskh.ttc
rm DevanagariMT.ttc
rm Diwan\ Kufi.ttc
rm Diwan\ Thuluth.ttf
rm Farah.ttc
rm Farisi.ttf
rm GujaratiMT.ttc
rm Gurmukhi.ttf
rm ITFDevanagari.ttc
rm Kailasa.ttc
rm Kokonor.ttf
rm KufiStandardGK.ttc
rm Mishafi\ Gold.ttf
rm Mishafi.ttf
rm Mshtakan.ttc
rm Muna.ttc
rm Nadeem.ttc
rm NewPeninimMT.ttc
rm Raanana.ttc
rm Sana.ttc
rm Waseem.ttc
