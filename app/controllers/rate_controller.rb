# encoding: UTF-8

class RateController < ApplicationController
  #####
  # Webページ解析
  require 'mechanize'
  # 日付関連
  require 'date'
  # rateupdateクラス
  require "#{Rails.root}/lib/rate_update"

  #####

  # DBに表示している情報より、最新の日付のデータを取得し表示する
  def index
#    latest_date = get_latest_date()
    dt = Date.today
    @rate = NewsRelease.order("rating_agency,news_id desc").where("news_date = '#{dt}'")
  end

  # DBへ登録しているデータをすべて表示
  def show
    @rate = NewsRelease.order("news_date desc,rating_agency,news_id desc")
  end

  # 最新の情報を取得し、DBへ登録
  def update
    ru = RateUpdate.new()
    ru.update_RI()
    ru.update_JCR()
    redirect_to :action => 'index'

  end
    

  def delete
    rate_all = NewsRelease.all
    rate_all.each { |rate|
      rate.destroy
    }

    redirect_to :action => 'index'

  end

 end

