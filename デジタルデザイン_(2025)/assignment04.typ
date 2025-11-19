// MIT No Attribution
// Copyright 2024, 2025 Shunsuke Kimura

#import "@preview/jaconf:0.6.0": jaconf, definition, lemma, theorem, corollary, proof, appendix
#import "@preview/codelst:2.0.2" :sourcecode

// デフォルト値でよい引数は省略可能
#show: jaconf.with(
  // 基本 Basic
  title: [レポート課題④ - デジタルデザイン (2025)],
  title-en: [Report Assignment 04 - Digital Design (2025)],
  authors: [鶴丸 倫琉 （2420125, 広島市立大学）],
  authors-en: [Michiru Tsurumaru (2420125, Hiroshima City University)],
  abstract: [このレポートでは、課題として提示された問題を解答する],
  keywords: ("状態遷移図", "状態遷移表"),
  // フォント名 Font family
  font-heading: "Noto Sans CJK JP",  // サンセリフ体、ゴシック体などの指定を推奨
  font-main: "Noto Serif CJK JP",  // セリフ体、明朝体などの指定を推奨
  font-latin: "Times New Roman",
  font-math: "New Computer Modern Math",
  // 外観 Appearance
  paper-margin: (top: 20mm, bottom: 27mm, left: 20mm, right: 20mm),
  paper-columns: 1,  // 1: single column, 2: double columna`
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

= 回答

== 状態遷移表

@fig:04-2 の通り。

#figure(
  placement: bottom,
  image("figures/04-2.png", width: 80mm),
  caption: [状態遷移表],
) <fig:04-2>

#colbreak()

== 状態遷移図

@fig:04-1 の通り。

#figure(
  placement: bottom,
  image("figures/04-1.svg", width: 90%),
  caption: [状態遷移図],
) <fig:04-1>

#colbreak()

== 状態遷移図 の PlantUML ソースコード

@fig:04-3 の通り。

#figure(
  placement: bottom,
  caption: [状態遷移図のPlantUMLソースコード],
  sourcecode(
    [```plantuml
    @startuml title 問題の状態遷移図
    [*] --> q_0: <math>(x_1, x_2) = (0, 0)</math>

    ' 0円
    q_0: 0
    q_0 --> q_0: <math>(0, 0)</math>
    q_0 --> q_1: <math>(1, 0)</math>
    q_0 --> q_5: <math>(0, 1)</math>

    ' 10円
    q_1: 0
    q_1 -> q_1: <math>(0, 0)</math>
    q_1 --> q_2: <math>(1, 0)</math>
    q_1 --> q_prime_0: <math>(0, 1)</math>

    ' 20円
    q_2: 0
    q_2 --> q_2: <math>(0, 0)</math>
    q_2 --> q_3: <math>(1, 0)</math>
    q_2 --> q_prime_1: <math>(0, 1)</math>

    ' 30円
    q_3: 0
    q_3 --> q_3: <math>(0, 0)</math>
    q_3 --> q_4: <math>(1, 0)</math>
    q_3 --> q_prime_2: <math>(0, 1)</math>

    ' 40円
    q_4: 0
    q_4 --> q_4: <math>(0, 0)</math>
    q_4 --> q_5: <math>(1, 0)</math>
    q_4 --> q_prime_3: <math>(0, 1)</math>

    ' 50円
    q_5: 0
    q_5 --> q_5: <math>(0, 0)</math>
    q_5 --> q_prime_0: <math>(1, 0)</math>
    q_5 --> q_prime_4: <math>(0, 1)</math>

    ' 60円
    q_prime_0: 1
    q_prime_0 --> q_0: <math>(0, 0)</math>
    q_prime_0 --> q_1: <math>(1, 0)</math>
    q_prime_0 --> q_5: <math>(0, 1)</math>

    ' 70円
    q_prime_1: 1
    q_prime_1 --> q_1: <math>(0, 0)</math>
    q_prime_1 --> q_2: <math>(1, 0)</math>
    q_prime_1 --> q_prime_0: <math>(0, 1)</math>

    ' 80円
    q_prime_2: 1
    q_prime_2 --> q_2: <math>(0, 0)</math>
    q_prime_2 --> q_3: <math>(1, 0)</math>
    q_prime_2 --> q_prime_1: <math>(0, 1)</math>

    ' 90円
    q_prime_3: 1
    q_prime_3 --> q_3: <math>(0, 0)</math>
    q_prime_3 --> q_4: <math>(1, 0)</math>
    q_prime_3 --> q_prime_2: <math>(0, 1)</math>

    ' 100円
    q_prime_4: 1
    q_prime_4 --> q_4: <math>(0, 0)</math>
    q_prime_4 --> q_5: <math>(1, 0)</math>
    q_prime_4 --> q_prime_3: <math>(0, 1)</math>
    @enduml
    ```]
  )
) <fig:04-3>
