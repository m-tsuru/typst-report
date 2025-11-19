// MIT No Attribution
// Copyright 2024, 2025 Shunsuke Kimura

#import "@preview/jaconf:0.6.0": jaconf, definition, lemma, theorem, corollary, proof, appendix

// デフォルト値でよい引数は省略可能
#show: jaconf.with(
  // 基本 Basic
  title: [レポート課題③ - デジタルデザイン (2025)],
  title-en: [Report Assignment 03 - Digital Design (2025)],
  authors: [鶴丸 倫琉 （2420125, 広島市立大学）],
  authors-en: [Michiru Tsurumaru (2420125, Hiroshima City University)],
  abstract: [このレポートでは、課題として提示された問題を解答する],
  keywords: (),
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

= 問題

== １×４デマルチプレクサを設計し，回路図を示せ．

@fig:03-1 の通り。

#figure(
  placement: bottom,
  image("figures/03-1.png", width: 90%),
  caption: [1x4デマルチプレクサの回路図],
) <fig:03-1>


== 全加算器をNANDゲートとNOTゲートで構成し，回路図を示せ．（ヒント：AND-OR2段回路はNAND-NAND2段回路で実現できる．）

@fig:03-2 の通り。

#figure(
  placement: bottom,
  image("figures/03-2.png", width: 90%),
  caption: [全加算器の回路図],
) <fig:03-2>

== 2入力マルチプレクサ（右図）を3個用いて，4入力マルチプレクサを構成せよ．

@fig:03-3 の通り。

#figure(
  placement: bottom,
  image("figures/03-4.png", width: 90%),
  caption: [4入力マルチプレクサの回路図],
) <fig:03-3>
