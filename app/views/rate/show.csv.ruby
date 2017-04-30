#encoding: utf-8

require 'kconv'
require 'csv'

CSV.generate do |csv|
   csv_header = ["リリース日","格付機関","NewsID","種別","タイトル","URL"]
   csv << csv_header
   @rate.each { |n|
   if n.rating_agency == "1" then
     links = "https://www.r-i.co.jp#{n.links}"
   else
     links = "https://www.jcr.co.jp#{n.links}"
   end
   csv_value = [
      n.news_date,
      n.rating_agency,
      n.news_id,
      n.syubetu,
      n.news,
      links
   ]
   csv << csv_value
  }
end.tosjis
