cd /d %~dp0
cd ..
rails runner .\lib\batch\auto_rate_update.rb -e production
