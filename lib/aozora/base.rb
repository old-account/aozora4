# -*- coding: utf-8 -*-

# 
# ダミーテキストを生成するためのクラスです。
# 青空文庫などの著作権フリーな文書をもとに整形された文字列を生成します。
# 
# Authors:: Tsukuru Tanimichi
# Version:: 0.1.0
# Copyright:: MIT License
# License:: 2013 Tsukuru Tanimichi
#
class Aozora

  # テキストの種類として指定できるSymbolのリスト
  Titles = lambda {
    titles = Array.new
    titles.push :kokoro
    titles.push :bocchan
    titles.push :hashire_merosu
    titles.push :joseito
    titles.push :lemon
    titles.push :london
    titles.push :ningen_shikkaku
    titles.push :pandorano_hako
    titles.push :sangetsuki
    titles.push :sanshiro
    titles.push :viyon
    titles.push :wagahaiwa_nekodearu
    titles.push :watashino_kojinshugi
    titles.push :__TEST_DATA__ # for test only
    return titles
  }.call

  #
  # Aozoraクラスのインスタンスを生成する。
  #
  # [title] 使用するテキストの種類を設定する
  # [length] テキストの長さを設定する
  #
  def initialize(title=:kokoro, length=100)
    validate_tilte(title)
    validate_length(length)

    if title.kind_of? Numeric
      title = Titles[title]
    end
    @text = read_file(title, length)
    return self
  end

  #
  # <i>Aozora</i><i>to_s</i>の別名です。
  # 生成されたダミーテキストを文字列として返します。
  #
  def text; to_s end

  #
  # テキストの種類として指定できるSymbolおよび番号の
  # 対応表を標準出力に表示します。
  #
  def self.titles; print self._titles end

  #
  # テキストに含まれるアルファベットを半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべてのアルファベットが半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def alpha(option)
    case option
    when :half, "half"
      @text.tr!("ａ-ｚ","a-z")
      @text.tr!("Ａ-Ｚ","A-Z")
      return self
    when :full, "full"
      @text.tr!("a-z","ａ-ｚ")
      @text.tr!("A-Z","Ａ-Ｚ")
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  #
  # テキストに含まれる数字を半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべての数字が半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def digit(option)
    case option
    when :half, "half"
      @text.tr!("０-９","0-9")
      return self
    when :full, "full"
      @text.tr!("0-9","０-９")
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  #
  # テキストに含まれる記号を半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべての記号が半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def sign(option)
    full_sign = "！＃＄％＆（）＊＋，ー．／：；＜＝＞？＠［］＾＿｀｛｜｝〜’＼"
    half_sign = "!#\$%&()*+,-./:;<=>?@[]^_`{|}~'\\"
    case option
    when :half, "half"
      @text.tr!(full_sign, half_sign)
      return self
    when :full, "full"
      @text.tr!(half_sign, full_sign)
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  # 
  # テキストをパラグラフ化します。
  #
  # [p_length] ひとつのパラグラフのおおまかな文字数を指定します。
  # [options] パラグラフに関するオプションをHashで受け取ります。
  #           {:space_head => true} を渡された場合、パラグラフの冒頭にスペースが入ります。
  #           {:_head => true} を渡された場合、パラグラフの冒頭にスペースが入ります。
  #
  def paragraph(p_length=40, options={})
    div_paragraph(p_length)

    if options[:space_head]
      @text = "　"+@text
      @text.gsub!(/\n/,"\n　")
    end

    if options[:blank_line]
      @text.gsub!(/\n/,"\n\n")
    end

    return self
  end

  #
  # ダミーテキストの末尾に、文章の途中であることを示す「…」を付します。
  #
  def dots
    @text += "…"
    return self
  end

  #
  # 生成されたダミーテキストを文字列として返します。
  #
  def to_s; @text.to_s end

  private
  
  def read_file(title, length)
    dir = File.expand_path(File.dirname(__FILE__))
    filename = dir+"/../../data/#{title}.txt"
    File.open(filename) do |full_sign|
      text = String.new
      loop do
        while (line = full_sign.gets) == nil
          full_sign.seek(0) 
        end
        text += line.chomp
        break if text.size >= length
      end
      return text[0...length]
    end
  end

  def self._titles
    titles = String.new
    titles += "+--+-------------------------+\n"
    titles += "| n| symbol                  |\n"
    titles += "+--+-------------------------+\n"
    # exclude __TEST_DATA__.txt
    (0..(Titles.size-2)).each do |i| 
      num_s = sprintf("%2d",i)
      sym_s = sprintf("%-25s",Titles[i].inspect)
      titles += "|#{num_s}|#{sym_s}|\n"
    end
    titles += "+--+-------------------------+\n"
    return titles
  end

  def div_paragraph(p_length)
    if not p_length.kind_of? Numeric
      raise "invalid argmument: p_length = #{p_length}"
    end
    if (p_length <= 0) or (p_length >= @text.size)
      raise "invalid argmument: p_length = #{p_length}"
    end

    offset = 0; ptr = 0; prev = 0
    loop do
      ptr = @text.index("。", offset)
      # 終端に辿り着いた場合。何もせずにループを抜ける
      return if not ptr
      # いきなりp_lengthを超えちゃった場合
      if p_length <= (ptr - offset)
        @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)]
        offset = ptr+2
        next
      end
      
      # prev_relとptr_relにp_lengthが挟まれるまで進めるループ
      loop do
        prev = ptr
        ptr = @text.index("。", (prev+1))

        # 終端に辿り着いた。何もせずにループを抜ける
        return if not ptr

        # relative length from offset
        ptr_rel  = ptr - offset
        prev_rel = prev - offset

        # prev_relとptr_relの間にp_lengthがある場合
        if ptr_rel >= p_length
          # 左右を比較して近い方に改行を入れてオフセットを更新
          if (p_length - prev_rel) < (ptr_rel - p_length)
            # prevの直後に改行を入れてオフセットを更新
            @text = @text[0..prev] + "\n" + @text[(prev+1)..(-1)]
            offset = prev+2
          else
            # ptrの直後に改行を入れてオフセットを更新
            @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)]
            offset = ptr+2
          end
          break
        end
      end # 内側のループ
    end # 外側のloop
    return;
  end

  def validate_tilte(title) 
    if title == nil
      raise "invalid argmument: title = nil"
    end

    if title.kind_of? Numeric
      if (title > (Titles.size - 1)) or (title < 0)
        raise "invalid argmument: title = #{title}"
      end
      return nil
    end
    
    if title.kind_of? Symbol
      Titles.each do |t|
        return nil if t == title
      end
      raise "invalid argmument: title = #{title}"      
    end

    raise "invalid argmument: title must be Symbol or Numeric" 
  end 

  def validate_length(p_length)
    if p_length == nil
      raise "invalid argmument: length = nil"
    end
    
    if not p_length.kind_of? Numeric 
      raise "invalid argument: length must be Numeric" 
    end

    if p_length < 0
      raise "invalid argmument: length = #{lenght}" 
    end
  end 
end

