cd /d %~dp0
cd ..
rails runner .\lib\batch\auto_rate_delete.rb -e production
