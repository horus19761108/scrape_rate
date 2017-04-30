# encoding:UTF-8

class SendMailer < ApplicationMailer
  def send_update_news(mail_addr)
#    @rate = ""
    mail to: mail_addr,    #送信先のメールアドレスを設定
         from: "自動メール",
         subject: "格付情報を更新しました"
  end
end
