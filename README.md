# README

JCRおよびR&Iの格付情報ニュースリリースのスクレイピングを行うサイトをRuby on Railsで構築。  
また、バッチ処理によるデータ更新・削除のプログラムおよびそれぞれのバッチファイルを作成。  
下記のバッチファイルをタスクスケジューラにて起動することで、データのメンテナンスの自動化が可能(Windowsの場合)  
　・更新バッチ：#{Rails.root}/batch/AutoUpdate.bat  
　・削除バッチ：#{Rails.root}/batch/AutoDelete.bat  
  
Things you may want to cover:  
  
* Ruby version  
ruby 2.3.3p222 (2016-11-21 revision 56859) [x64-mingw32]  
* gem version  
gem 2.6.11  
* Rails version  
Rails 5.0.2  
* MySQL version  
mysql  Ver 14.14 Distrib 5.7.17, for Win64 (x86_64)  
* Operating System  
Windows 10 Home version 1703(build 15063.138)  
  
* 下記の環境変数を設定する必要あり  
RAILS_SERVE_STATIC_FILES  
SCRAPE_RATE_DATABASE_PASSWORD  
SCRAPE_RATE_DATABASE_USER  
SECRET_KEY_BASE  
DEV_MAIL_ADDR  
DEV_MAIL_PASS  
DEV_MAIL_SERVER  

