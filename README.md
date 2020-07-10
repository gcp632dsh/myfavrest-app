# Portfolio
## はじめに
こんにちは。閲覧いただきありがとうございます。  

現在、ポートフォリオとして、  
「自分のコミュニティ内で共有し合える飲食店投稿・口コミアプリ」を作成しようとしています。  

このポートフォリオは現在作成中であり、未完成となっています。  

今までの勉強記録は「やってきたこと」の箇所に記載しております。 随時更新中です。  

## 使用言語  
* Ruby 2.6.5  Rails 5.2.4.2  
* （現在未使用：今後Vue.js使用予定）  

## 開発背景（想い）
他の飲食店投稿アプリは数多くあります。  
そんな中でも、やはり自分の身近な人の感想というのが、一番信頼できる情報であると思う人が多いと感じています。  
そのため、自分の身近な人の感想をもっと気軽に知れたら、という想いで、  
Facebookのコミュニティのような形で飲食店の情報を共有し合うサイトを作成しようと思い立ちました。  

## 機能一覧
* ユーザー登録・ログイン機能（devise使用）
* コミュニティ別管理機能（新規コミュニティ作成、コミュニティ詳細表示、編集、削除、コミュニティメンバ管理、管理者設定、公開範囲設定、加入申請/承認・退会）
* 店舗投稿機能（新規投稿、投稿一覧表示、投稿詳細表示、編集、削除）
* 地図表示、地図を用いた店舗住所検索（Google API：Maps Javascript API、Geocoding API、Places API使用）
* ページネーション機能（Kaminari）
* いいね機能（Ajax）
* 口コミ投稿機能（新規投稿、一覧表示、編集、削除）
* 画像アップロード機能（ActiveStorage、MiniMagic）
* 検索機能（Ransack使用）
* フォロー・フォロワー機能
* ホットペッパーAPIを用いたホットペッパーグルメ情報の検索機能（店舗情報投稿補助機能として使用）
* Rspecによる自動テスト機能

## 環境
開発環境：docker、docker-compose  
本番環境（現在構築中）：AWS（VPC、EC2、RDS、S3、Route53、ALB、ACM）  
                       Webサーバ：Nginx  
                       APサーバ：Rails  
                       DBサーバ：MySQL  
その他：GitHub（Issueとブランチを連携させてプルリクベースでの開発）  
　　　　CircleCI、Capistrano  
  
## やってきたこと
* 2019/12/21～2020/1  HTML/CSS/jQueryを用いたWebサイト模写（3サイト）  
* 2020/2  Progate、ドットインストール（Linuxコマンド、JavaScript、Ruby、Git）、  
          Linux標準教科書にてLinux学習、UdemyにてGit/GitHub学習  
* 2020/3～2020/4/18  RailsチュートリアルにてRuby on Rails学習、UdemyにてAWS学習（VPC、EC2、Route53）  
* 2020/4/19～　ポートフォリオ作成開始   
**以下は、実施済みの内容を、実施順に記載しています**  
- 4/19  Rails環境構築、mysqlを用いてDB接続、  
        レンダリングを用いたヘッダ・フッタ作成（静的ページ）、投稿機能作成（新規投稿、投稿一覧表示、投稿詳細表示、編集、削除）、  
- 4/20～22  ユーザー登録・ログイン機能（devise導入・カスタマイズも実施）、各画面の認可機能、  
- 4/22,23  検索機能（ransack導入・カスタマイズも実施）、Rspec（自動テスト）実装しつつTDDを目指し始める、  
- 4/24～26 いいね機能（テーブルのリレーション実装、Ajax実装）  
- 4/27  GitHubにリポジトリを作成  
- 4/27,28  コメント機能（Ajax実装）  
- 4/28～29 本番環境準備のためEC2インスタンス作成・ドメイン取得しRoute53にてドメイン名でWebサーバにHTTPアクセスできるように、  
           RDSでデータベース作成しEC2からアクセスできるように  
           画像アップロード機能（CarrierWave導入）  
- 4/30  ページネーション機能（kaminari導入）、フォロー・フォロワー機能（DBのリレーション活用）、  
        Gitでコンフリクトを発生させ、解決する演習実施  
- 5/1～2  地図検索・表示機能（GoogleMap APIの導入）  
- 5/2  UdemyにてGitチーム開発の学習  
- 5/3  GitHubでissueを発行し、ブランチと連携させプルリクベースでの開発を開始  
        投稿画面の機能強化（項目追加）開始  
- 5/4  「入門Docker」(https://y-ohgi.com/introduction-docker/)  や他サイトにてDocker学習、仕組みや基本コマンド理解  
- 5/5～8 投稿画面の項目追加（各飲食店の情報をより詳細に知ることができるようにする）
- 5/9,10 Node.js、Expressについて学習、ローカル環境構築。画面表示やHTTPリクエスト/レスポンスを利用した機能を動作確認。
- 5/11～19 投稿画面、ユーザ登録画面の項目追加  
           フォロー・フォロワー機能をAjax化、フォロー・フォロワー数を各ユーザ詳細画面に表示  
           Rspec学習、書籍にて学習しながらテストコード記述し、テスト実施（modelスペック、FactoryBot使用）  
- 5/20～5/29  Docker,Docker-compose学習、開発環境にDocker導入（Dockerfile,Docker-compose.yml作成）
- 5/30  投稿画面における画像アップロード機能をActiveStorageに変更
- 6/1,2   ユーザ登録・編集・表示画面の機能強化（date_select、strftime、JSでのクリップボードコピー機能）  
- 6/3   簡単ログイン機能実装  
- 6/4,5   コミュニティ機能の設計、画面デザインのワイヤーフレーム作成
- 6/6   SCSSを用いた画面デザイン実装
- 6/7   ActiveStorage、MiniMagicを用いた画像アップロード・サイズ整形機能
- 6/8,9   SCSSを用いた画面デザイン実装
- 6/10,11  helperメソッドを使った並び替えボタンの実装
- 6/12～15   コミュニティ機能の実装  
- 6/15～18   DockerにNginxコンテナ追加し、Nginx(Web)+Puma/Rails(AP)+MySQL(DB)のサーバ構成に変更  
- 6/19,20    コミュニティ機能の機能強化
- 6/21,22    ユーザ詳細画面の画面レイアウト改修
- 6/23,24    ユーザ一覧画面作成
- 6/25～28   自ユーザ用画面作成 
- 6/29～7/2  コミュニティ加入申請/承認機能、承認待ち画面の実装
- 7/3        コミュニティ退会機能の実装
- 7/4～　　　 口コミ評価の分析グラフ機能を追加
 
**現在実施中：**
- 各画面のレイアウト改修
- 本番環境へのデプロイ（EC2で環境構築）

## 学習において特に意識している点（上位3点）
1. ＜学習基本方針＞  
アウトプットベースで習得する（インプット3；アウトプット7くらいの比率で、ポートフォリオ作成を通じて学習する）  
2. ＜使える技術を身に着けるための工夫＞  
個々の用語や技術、仕組みをできるだけ腹落ちさせる。  
どうしても腹落ちできないものは、前提知識が足りないことが原因と捉え、  
前提知識を把握し、その知識から学習する（例：AWS、Docker、Railsの仕組みや個々のプログラムの意味、Webの仕組み等）  
ただし、あまりに時間がかかる場合は、後々になって理解できるようになる可能性もあるため、  
「課題事項」として記録しておき、後日理解するようにする。  
3. ＜マインド＞  
自分の考えに浮かぶバイアスに注意しつつ、素直な姿勢でまずは愚直に吸収する  
