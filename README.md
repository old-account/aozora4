# Aozora

aozoraはダミーテキストを生成するライブラリです。Web製作時など、作成中のHTMLに何でも良いから文章を書き込んで、完成時のサイト雰囲気を確認したいという場合がよくあります。そういった時に便利なのがダミーテキストです。aozoraは、青空文庫などの著作権フリーなテキストをもとにダミーテキストを生成するライブラリです。

## 使い方
Aozoraインスタンスをputsすると、夏目漱石の「こころ」から冒頭の100文字が出力されます。

    puts Aozora.new
    #=> "私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、その方が私にとって自然だからである。私はその人の記憶を呼び起すごとに、すぐ「"

### 基本的な使い方

Aozora.newに第一引数、第二引数を渡すと、生成されるテキストの種類や長さを変更できます。

    puts Aozora.new(:bocchan, 23)
    #=> "親譲りの無鉄砲で小供の時から損ばかりしている。"

    puts Aozora.new(:hashire_merosu, 1000)
    #=> "メロスは激怒した。必ず、かの邪智暴虐の王を除かなければならぬと決意した。メロスには政治がわからぬ。メロスは、村の牧人である。笛を吹き、羊と遊んで暮して来た。けれども邪悪に対しては、人一倍に敏感であった。きょう未明メロスは村を出発し、野を越え山越え、十里はなれた此のシラクスの市にやって来た。メロスには父も、母も無い。女房も無い。十六の、内気な妹と二人暮しだ。この妹は、村の或る律気な一牧人を、近々、花婿として迎える事になっていた。結婚式も間近かなのである。メロスは、それゆえ、花嫁の衣裳やら祝宴の御馳走やらを買いに、はるばる市にやって来たのだ。先ず、その品々を買い集め、それから都の大路をぶらぶら歩いた。メロスには竹馬の友があった。セリヌンティウスである。今は此のシラクスの市で、石工をしている。その友を、これから訪ねてみるつもりなのだ。久しく逢わなかったのだから、訪ねて行くのが楽しみである。歩いているうちにメロスは、まちの様子を怪しく思った。ひっそりしている。もう既に日も落ちて、まちの暗いのは当りまえだが、けれども、なんだか、夜のせいばかりでは無く、市全体が、やけに寂しい。のんきなメロスも、だんだん不安になって来た。路で逢った若い衆をつかまえて、何かあったのか、二年まえに此の市に来たときは、夜でも皆が歌をうたって、まちは賑やかであった筈だが、と質問した。若い衆は、首を振って答えなかった。しばらく歩いて老爺に逢い、こんどはもっと、語勢を強くして質問した。老爺は答えなかった。メロスは両手で老爺のからだをゆすぶって質問を重ねた。老爺は、あたりをはばかる低声で、わずか答えた。「王様は、人を殺します。」「なぜ殺すのだ。」「悪心を抱いている、というのですが、誰もそんな、悪心を持っては居りませぬ。」「たくさんの人を殺したのか。」「はい、はじめは王様の妹婿さまを。それから、御自身のお世嗣を。それから、妹さまを。それから、妹さまの御子さまを。それから、皇后さまを。それから、賢臣のアレキス様を。」「おどろいた。国王は乱心か。」「いいえ、乱心ではございませぬ。人を、信ずる事が出来ぬ、というのです。このごろは、臣下の心をも、お疑いになり、少しく派手な暮しをしている者には、人質ひとりずつ差し出すことを命じて居ります。御命令を拒めば十字架にかけられて、殺されます。きょうは、六人殺されました。」聞いて、"

テキストとして使用できる作品の一覧とSymbolの対応表は下記の通りです。

| 作品                     | symbol                   | id |
| ----------------------- |:------------------------:| ---:|
| 『こころ』夏目漱石        | :kokoro                   | 0 | 
| 『坊っちゃん』夏目漱石     | :bocchan                 | 1 | 
| 『走れメロス』太宰治       | :hashire\_merosu         | 2 | 
| 『女生徒』太宰治          | :joseito                 | 3 | 
| 『檸檬』梶井基次郎        | :lemon                   | 4 | 
| 『倫敦塔』夏目漱石        | :london                   | 5 | 
| 『人間失格』太宰治        | :ningen\_shikkaku         | 6 | 
| 『パンドラの箱』太宰治     | :pandorano\_hako         | 7 | 
| 『山月記』中島敦          | :sangetsuki               | 8 | 
| 『三四郎』夏目漱石        | :sanshiro                 | 9 | 
| 『ヴィヨンの妻』太宰治     | :viyon                   | 10 | 
| 『吾輩は猫である』夏目漱石 | :wagahaiwa\_nekodearu    | 11 | 
| 『私の個人主義』夏目漱石   | :watashino\_kojinshugi   | 12 | 

シンボルの代りにidで指定することもできます。

    puts Aozora.new(1, 23)
    #=> "親譲りの無鉄砲で小供の時から損ばかりしている。"

タイトルを指定するためのシンボルと番号の一覧は`Aozora.titles`を呼ぶと確認できます。

    irb(main):001:0> Aozora.titles
    +--+-------------------------+
    | n| symbol                  |
    +--+-------------------------+
    | 0|:kokoro                  |
    | 1|:bocchan                 |
    | 2|:hashire_merosu          |
    | 3|:joseito                 |
    | 4|:lemon                   |
    | 5|:london                  |
    | 6|:ningen_shikkaku         |
    | 7|:pandorano_hako          |
    | 8|:sangetsuki              |
    | 9|:sanshiro                |
    |10|:viyon                   |
    |11|:wagahaiwa_nekodearu     |
    |12|:watashino_kojinshugi    |
    +--+-------------------------+

Aozoraクラスには`to_s`が実装されており、呼び出されるとダミーテキストを返すようになっています。`Aozora#text`を使っても良いです。これは単なる別名です。

    str1 = Aozora.new.text
    str2 = Aozora.new.to_s
    puts str1 #=> "私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、その方が私にとって自然だからである。私はその人の記憶を呼び起すごとに、すぐ「"
    puts str2 #=> "私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、その方が私にとって自然だからである。私はその人の記憶を呼び起すごとに、すぐ「"

### その他の機能

全角半角の変換やパラグラフの分割などができます。詳細は[RDoc](https://dl.dropboxusercontent.com/u/67723753/AozoraRDoc/doc/index.html)をご覧ください。

## Installation

Add this line to your application's Gemfile:

    gem 'aozora'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aozora

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
