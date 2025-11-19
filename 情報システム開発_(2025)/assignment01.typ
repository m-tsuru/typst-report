// MIT No Attribution
// Copyright 2024, 2025 Shunsuke Kimura

#import "@preview/jaconf:0.6.0": jaconf, definition, lemma, theorem, corollary, proof, appendix

// デフォルト値でよい引数は省略可能
#show: jaconf.with(
  // 基本 Basic
  title: [簡易的な学生成績管理システムの設計と実装 #linebreak() 情報システム開発 (2025)],
  title-en: [Design and Implementation of a Simple Student Grade Management System #linebreak() Information Systems Development (2025)],
  authors: [鶴丸 倫琉 （2420125, 広島市立大学）],
  authors-en: [Michiru Tsurumaru (2420125, Hiroshima City University)],
  abstract: [このレポートでは、情報システム開発の課題として、Java / Android を用いて簡易的な学生成績管理システムを設計・実装した。システムは、学生情報の登録、成績の入力・編集、成績の表示機能を備えており、クラスとインスタンスをきちんと設計して実装されている。ユーザーインターフェースは直感的で使いやすく、基本的なエラーチェックも実装されている],
  keywords: ([情報システム開発], [クラス], [Java], [Android]),
  // フォント名 Font family
  font-heading: "Noto Sans CJK JP",  // サンセリフ体、ゴシック体などの指定を推奨
  font-main: "Noto Serif CJK JP",  // セリフ体、明朝体などの指定を推奨
  font-latin: "Times New Roman",
  font-math: "New Computer Modern Math",
  // 外観 Appearance
  paper-margin: (top: 20mm, bottom: 27mm, left: 20mm, right: 20mm),
  paper-columns: 1,  // 1: single column, 2: double column`
  // page-number: 1/1,  // e.g. "1/1"
  column-gutter: 4%+0pt,
  spacing-heading: 1.5em,
  bibliography-style: "sice.csl",  // "sice.csl", "rsj.csl", "ieee", etc.
  abstract-language: "ja",  // "ja" or "en"
  keywords-language: "ja",  // "ja" or "en"
  front-matter-order: ("title", "authors", "title-en", "authors-en", "abstract", "keywords"),  // 独自コンテンツの追加も可能
  front-matter-spacing: 1.5em,
  front-matter-margin: 2.0em,
  // 見出し Headings
  heading-abstract: [*Abstract--*],
  heading-keywords: [*Keywords*: ],
  heading-bibliography: [参　考　文　献],
  heading-appendix: [付　録],
  // フォントサイズ Font size
  font-size-title: 16pt,
  font-size-title-en: 12pt,
  font-size-authors: 12pt,
  font-size-authors-en: 12pt,
  font-size-abstract: 10pt,
  font-size-heading: 12pt,
  font-size-main: 9pt,
  font-size-bibliography: 9pt,
  // 補足語 Supplement
  supplement-image: [図],
  supplement-table: [表],
  supplement-separator: [: ],
  // 番号付け Numbering
  numbering-headings: "1.1",
  numbering-equation: "(1)",
  numbering-appendix: "A.1",  // #show: appendix.with(numbering-appendix: "A.1") の呼び出しにも同じ引数を与えてください。
)

// この文書特有の関数を定義
// 赤字で警告する
#let red-warn(it) = text(it, fill: rgb(red), weight: "bold")
// リンクを青文字にする
#show link: set text(fill: blue)

// 句読点をカンマとピリオドに変換
#show "、": "，"
#show "。": "．"

#set par(
  leading: 1.2em,
  spacing: 1.2em
)

= 導入

課題は、Android アプリケーションとして動作する簡易的な学生成績管理システムを設計・実装することである。本システムは、学生情報の登録、成績の入力・編集、成績の表示機能を備えている。講義では、以下の通り、実装の達成度合いが示されている。

+ 最初に初期画面を作り，学生情報管理のアクティビティを作る
+ 学生情報の登録ができる
+ 学生情報の全表示ができる
+ 学生の成績情報管理のアクティビティを作る
+ 指定した一人の学生の成績情報の表示ができる（最初は何も入っていないので，何も入っていないと表示できれば良い）
+ 学生の成績情報（一つで良い）の登録ができる
+ 学生一人に複数の成績情報の登録ができる（Student クラスの成績情報を HashMap や ArrayList を使って管理する）
+ その他: 各自で工夫したこと

私はこの課題のステップ 8 まで実装を行った。

= データ構造とメソッドについて

本システムは学籍情報と成績情報の管理を目的としている。最小限の機能を果たすために、まず設計されるべきクラスとして、`Student` クラスと、`LectureGrade` クラスがある。このうち、`Student` クラスは学生一人単位の基本情報（学籍番号、氏名、学年など）を保持するが、これを複数人保持する名簿の役割を果たすクラスとして、 `StudentInfo` クラスを実装している。StudentInfo クラスには、インスタンスに対して、一通りの CRUD 操作を行うメソッドを実装した。`get...`, `add...`, `update...`, `delete...` といったメソッド群である。これにより、学生情報の登録、表示、編集、削除が可能となる。また、この操作は大変クリティカルなものであるから、データの整合性を維持する設計とした。特に削除操作では確認ダイアログを必ず表示し、誤操作によるデータ損失を防いでいる。ユーザー体験の向上にも配慮し、成績一覧や学生リストの表示にはListViewとSimpleAdapterを採用して動的なリスト更新を実現した。さらに、プルリフレッシュ機能（SwipeRefreshLayout）やスピナーによる並び替え機能を導入し、直感的な操作を可能にしている。レイアウトXMLでは、UI部品の属性（layout_width, focusable等）を適切に設定し、表示崩れや操作性の問題を防止した。

その他、特殊なクラスとして `LectureGrade` クラスの成績を示す、`GradePoint` 列挙型を実装した。これは、内部的には A~F の形で成績情報を保持しつつ、呼び出す時に弊学の成績情報の評価を「秀」や数値としての GradePoint (秀であれば 4 と言った具合) の形で厳密に管理できるようになった。今回は実装されていないが、GPA 計算のメソッドを実装した際には、この列挙型を参照するだけで有用であると考えられる。

LectureGrade クラスは、は各講義の成績情報（講義名、単位数、評価など）を１つ単位で持つ。これは、Student クラスから、List<LectureGrade> 型のフィールドとして保持される。ここから、各学生が複数の講義成績を持つことが可能となる。

なお、クラス図は、巻末の@fig:class-overview に示す。

= ユーザインタフェース

本アプリのUI/UX設計では、ユーザーが学生情報や成績情報を「直感的に操作できる」ことと、「視覚的に分かりやすく快適に利用できる」ことを重視した。これを実現するために、画面構成、操作性、視認性、応答性といった複数の観点から設計上の工夫を行っている。

ユーザインタフェースについては、前回までと同様、 Android のアクティビティを用いて実装した。各アクティビティは、XML レイアウトファイルで画面構成を定義し、Java コードで動作を実装している。レスポンシブかつ無理のない画面構成を心がけており、学生リスト画面・成績一覧画面・編集画面といった各画面の役割を明確に分け、ユーザーが迷わず目的の操作に到達できる導線を設けた。視認性とデザイン面では、レイアウトXML内で各UI部品の属性（layout_width、layout_height、focusable、padding、margin等）を適切に設定し、情報量が多い画面でも見やすく整理された表示となるようにした。文字サイズや余白にも配慮し、画面の密度を適度に保つことで操作ミスを防止している。

応答性とフィードバックの面では、操作に対して即時に反応するインタラクションを重視した。例えば、削除操作時には確認ダイアログを表示し、ユーザーが本当に削除するかどうかを確認できるようにしている。

== 画面遷移

メインメニューを開くと、主に学生情報管理画面と成績情報管理画面の2つの画面が存在する（@fig:画面遷移）。学生情報管理画面では、学生の登録、表示、編集、削除が行える。一方、成績情報管理画面では、特定の学生の成績情報の登録、表示、編集、削除が行える。

#figure(
  placement: bottom,
  image(
    "figures/screenShot.png",
    width: 100%
    ),
    caption: [画面遷移概要]
   )<fig:画面遷移>

== 学生情報・成績情報のリスト表示

特筆すべき部分は、成績一覧と学生一覧のリストの実装である。これは、ListView ウィジェットを用いて実装されており、各リストアイテムの表示内容はカスタムアダプタを通じて動的に生成される。たくさんの学生情報や成績情報が登録された場合でも、スクロール可能なリストとして表示される。

= 反省

今回、`Student` の `List<LectureGrade>` の操作は `StudentInfo` 経由で行う設計としたが、`Student` クラスに直接成績情報を操作するメソッドを実装することも考えられた。例えば、`Student` クラスに `addLectureGrade(LectureGrade grade)` メソッドを追加することで、成績情報の追加をより直感的に行えるようになる。この方法では、成績情報の管理が `Student` クラス内で完結するため、コードの可読性と保守性が向上する可能性がある。個人的なクラス設計の感覚からは、`Student` クラスが自分の成績情報を直接管理する方が自然であるような気が正直するため、失敗であったなと考えている。これは、クラス図を書き直していて気づくことができた。このように、最初に UML 図を書き、検証することは大事であることに改めて気付いた。実装した後に気づいても、後の祭りである。次からは、ちゃんと考えてから実装したい。

#colbreak()

= 図表

#figure(
  placement: bottom,
  image(
    "figures/classOverview.svg",
    width: 100%
    ),
    caption: [クラスの概要]
   )<fig:class-overview>

#colbreak()

#figure(
  placement: bottom,
    image(
    "figures/activityFigure.svg",
    width: 100%,
    ),
    caption: [主要アクティビティ図]
  )<fig:activity-overview>

#figure(
  placement: bottom,
  image(
    "figures/modifyGradeFigure.svg",
    width: 100%
    ),
    caption: [成績情報変更のアクティビティ図]
   )<fig:activity-overview2>
