#the demo for ios-web websocket
	
##run socket server
	
	cd faye-web
	bundle exec thin -e production -l log/faye.log -R faye/config.ru -p 9292 start  

##run web server
	
	cd faye-web
	rails s
	
##run ios
xcode export faye-ios then build