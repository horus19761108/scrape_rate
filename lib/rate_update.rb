# encoding: UTF-8

class RateUpdate
  #####
  # Webページ解析
  require 'mechanize'
  # 日付関連
  require 'date'
  # ActiveRecord
  require "#{Rails.root}/app/models/news_release"


  ##### クラスメソッド
  # news_releaseテーブルに1件INSERT
  def self.insert_news(news_id, news_date, rating_agency, syubetu, news, links)
    news_release = NewsRelease.new(
      :news_id		=> news_id,
      :news_date	=> news_date,
      :rating_agency	=> rating_agency,
      :syubetu		=> syubetu,
      :news		=> news,
      :links		=> links
    )
    news_release.save
  end

  def self.get_nodeset(url)
    # ページ情報を取得する(Nodesetを返す)
    agent = Mechanize.new
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    agent.user_agent_alias = 'Windows Mozilla'
    doc = agent.get(url)
    return doc
  end

  ##### インスタンスメソッド
  def update_RI()
    #取得するページ
    url = 'https://www.r-i.co.jp/jpn/cfp/news.html#tab-anchor-rating-file'
    doc = RateUpdate.get_nodeset(url)

    out_text = ""

    # DB格納済みチェック用テーブルの作成
    check_record = NewsRelease.select("news_id").where("rating_agency = '1'")
    
    #解析した内容から要素の取得し、体裁を整えてDBへ出力
    #Chromeの解析ツールにて、取得したいエレメントを選択し、Copy⇒copy selecter
    doc.css('#news-01 > div > div.link-block-link').each { |block_tag|
      news_date = block_tag.at_css('p.link > span').text[1,10]
      rating_agency = '1'
      syubetu = block_tag.at_css('p.icon.last > img:nth-child(1)')["title"]
      news = block_tag.at_css('p.link > a').text
      links = block_tag.at_css('p.link > a')['href']
      href_len = links.length
      id_index = links.rindex("e_")
      news_id = links[id_index+2,href_len-id_index-6]
      # DBへ格納済みかチェック
      chk_result = 0
      check_record.each { |chk| 
        if chk.news_id == news_id
          chk_result =1
          break
        end
      }
      # 格納していなければInsertする
      if chk_result == 0
        RateUpdate.insert_news(news_id, news_date, rating_agency, syubetu, news, links)
      end
    }

  end

  def update_JCR()
    #取得するページ
    url = 'https://www.jcr.co.jp/release/'
    doc = RateUpdate.get_nodeset(url)
    
    out_text = ""
    # DB格納済みチェック用テーブルの作成
    check_record = NewsRelease.select("news_id").where("rating_agency = '2'")

    doc.css('#content > div > div.mainColumn > section > dl').each { |dl_tag|
#      w_date = dl_tag.at_css('dt').text
#      news_date = "#{w_date[0,4]}-#{w_date[5,2]}-#{w_date[8,2]}"
      news_date = dl_tag.at_css('dt').text
      dl_tag.css('dd').each { |dd_tag|
        dd_class = dd_tag["class"] 
       #ddタグのclass属性によって、種別をセットする
        if dd_class.include?("j01") then
          syubetu = "事法"
        elsif dd_class.include?("j02") then
          syubetu = "金法"
        elsif dd_class.include?("j03") then
          syubetu = "パブリック"
        elsif dd_class.include?("j04") then
          syubetu = "SF"
        else
          syubetu = "ソブリン"
        end
        links = dd_tag.at_css('a')['href']
        href_len = links.length
        id_index = links.rindex("/")
        news_id = links[id_index+1,href_len-id_index-5]
        rating_agency = '2'
        news = dd_tag.at_css('a > span').text
        # DBへ格納済みかチェック
        chk_result = 0
        check_record.each { |chk| 
          if chk.news_id == news_id
            chk_result =1
            break
          end
        }
        # 格納していなければInsertする
        if chk_result == 0
          RateUpdate.insert_news(news_id, news_date, rating_agency, syubetu, news, links)
        end
      }
    }

  end

####

end
