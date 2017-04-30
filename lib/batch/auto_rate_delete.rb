# encoding: UTF-8

# 日付関連
require 'date'
# ActiveRecord
require "#{Rails.root}/app/models/news_release"

#メイン
class Batch
  class AutoRateDelete
    def self.execute()
      today = Date.today()
      wk_dt = today << 1
      dt = Date.new(wk_dt.year, wk_dt.month, 1)
      NewsRelease.where("news_date < '#{dt}'").delete_all
    end
  end
end

Batch::AutoRateDelete.execute()