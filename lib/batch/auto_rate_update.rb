# encoding: UTF-8

# rateupdateクラス
require "#{Rails.root}/lib/rate_update"
require "#{Rails.root}/app/mailers/send_mailer"
require "#{Rails.root}/app/models/user"

#メイン
class Batch
  class AutoRateUpdate
    def self.execute()
      ru = RateUpdate.new()
      ru.update_RI()
      ru.update_JCR()
      mail_list = User.all
      mail_list.each {|t|
        SendMailer.send_update_news(t.email).deliver
      }
    end
  end
end

Batch::AutoRateUpdate.execute()