// MIT No Attribution
// Copyright 2024, 2025 Shunsuke Kimura

#import "@preview/jaconf:0.6.0": jaconf, definition, lemma, theorem, corollary, proof, appendix

// デフォルト値でよい引数は省略可能
#show: jaconf.with(
  // 基本 Basic
  title: [レポート課題① - ネットワークプロトコル (2025)],
  title-en: [Report Assignment 01 - Network Protocols (2025)],
  authors: [鶴丸 倫琉 （2420125, 広島市立大学）],
  authors-en: [Michiru Tsurumaru (2420125, Hiroshima City University)],
  abstract: [このレポートでは、課題として、無線LANの標準化のトレンドとVPNの仕組みと種類について説明する。無線LANはIEEE 802.11ワーキンググループによって標準化されており、様々な規格が存在する。VPNは公衆ネットワーク上で安全な通信を実現する技術であり、IPSec、L2TP、TLS/SSLなどの種類がある。],
  keywords: ([無線LAN], [VPN], [IEEE 802.11]),
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

== 無線LANの標準化のトレンドを調べてまとめよ

無線 LAN (Wi-Fi) の標準化は、米国電気電子学会 (IEEE; Institute of Electrical and Electronics Engineers) の IEEE 802.11 ワーキンググループによって行われている@wi-fi-evolution。IEEE 802.11 は、1997 年に最初の標準が策定されて以来、継続的に改訂と拡張が行われてきた。 主要な改訂には、IEEE 802.11a (1999 年)、IEEE 802.11b (1999 年)、IEEE 802.11g (2003 年)、IEEE 802.11n (2009 年)、IEEE 802.11ac (2013 年)、IEEE 802.11ax (2019 年) などがある@wi-fi-certification。これらの改訂は、データ転送速度の向上、周波数帯域の拡大、セキュリティ機能の強化、マルチユーザ環境への対応などを目的としている@wi-fi-certification。

先に仕様を簡単にまとめた表を示す(@lan) @wi-fi-certification。

#figure(
  caption: [主な無線 LAN 規格の概要],
  placement: bottom,
    table(
    columns: 6,
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
    align: (x, y) => ( center + horizon),
    table.header(
      [規格], [別名], [発表年], [周波数帯域], [最大データ転送速度], [主な特徴]
    ),
    [IEEE 802.11], [-], [1997 年], [2.4 GHz 帯], [2 Mbps], [CSMA/CA \ アクセス制御赤外線方式サポート],
    [IEEE 802.11a], [-], [1999 年], [5 GHz 帯], [54 Mbps], [OFDM 変調方式 \ 干渉が少ない],
    [IEEE 802.11b], [-], [1999 年], [2.4 GHz 帯], [11 Mbps], [DSSS 変調方式 \ 広く普及],
    [IEEE 802.11g], [-], [2003 年], [2.4 GHz 帯], [54 Mbps], [OFDM 変調方式 \ IEEE 802.11b と互換性],
    [IEEE 802.11n], [Wi-Fi 4], [2009 年], [2.4 GHz 帯・5 GHz 帯], [600 Mbps (MIMO 4x4)], [MIMO 技術 \ チャネルボンディング],
    [IEEE 802.11ac], [Wi-Fi 5], [2013 年], [5 GHz 帯], [6.93 Gbps (MIMO 8x8)], [MU-MIMO 技術 \ 最大 160 MHz 帯域幅],
    [IEEE 802.11ax], [Wi-Fi 6], [2019 年], [2.4 GHz 帯・5 GHz 帯], [9.6 Gbps], [OFDMA 技術 \ ターゲットウェイクタイム (TWT) \ BSS カラーリング]
  )
) <lan>

=== IEEE 802.11 (1997 年)

IEEE 802.11 は、1997 年 6 月に定義された。周波数帯域は 2.4 GHz 帯を使用し、最大データ転送速度は 2 Mbps であった。物理レイヤ規格と MAC レイヤ規格から構成され、一つの MAC レイヤ企画で複数の物理レイヤ企画をサポートする構造となっている。面白い記述としては、周波数ホッピング方式や直接拡散方式といった方式の他にも、赤外線方式のものも物理レイヤとしてサポートしている点である。

加えて、CSMA/CA (Carrier Sense Multiple Access with Collision Avoidance) というアクセス制御方式を採用しており、無線通信における衝突回避のためのメカニズムが導入されている。これは、パケットの送信をする前に、他の装置がパケット信号を送出していないか確認することで、衝突の可能性を減少させるものである。

=== IEEE 802.11a (1999 年)

IEEE 802.11a は、1999 年に策定された。5 GHz 帯を使用し、最大データ転送速度は 54 Mbps である。OFDM (Orthogonal Frequency Division Multiplexing; 直交周波数分割多重方式) という変調方式を採用しており、高速なデータ転送が可能となっている。また、2.4 GHz 帯に比べて干渉が少ないため、より安定した通信が可能である。なお、この帯域は、日本国内においては、屋外の利用が禁止されている@smalldata。そのため、欧米の仕様と若干の周波数帯域が異なり、使いにくかった覚えがある、と父が述べていた。そういった背景もあり、あまり普及しなかったとされる。

=== IEEE 802.11b (1999 年)

IEEE 802.11b も、前述の IEEE 802.11a とほぼ同じタイミングで 1999 年に策定された。2.4 GHz 帯を使用し、最大データ転送速度は 11 Mbps である。DSSS (Direct Sequence Spread Spectrum) という変調方式を採用しており、比較的安価なハードウェアで実装可能であったため、広く普及した。IEEE 802.11b は、IEEE 802.11a と比較して、通信距離が長いという利点がある一方で、干渉に弱いという欠点もある。

IEEE 802.11b は、物理レイヤのみを規格化しており、MACレイヤには、従来の IEEE 802.11 規格を引き継いでいる。

=== IEEE 802.11g (2003 年)

IEEE 802.11g は、2003 年に策定された。2.4 GHz 帯を使用し、最大データ転送速度は 54 Mbps である。OFDM 変調方式を採用しており、IEEE 802.11a と同様の高速なデータ転送が可能である。IEEE 802.11g は、IEEE 802.11b と互換性があり、既存の IEEE 802.11b デバイスと共存できるため、普及が進んだ。ネットワーク内にIEEE 802.11b機器が1台でも混在すると、通信速度が大幅に低下するという問題がある。これは、後継規格が持つ下位互換性により、ネットワーク全体が最も低速な802.11bモードに合わせて動作してしまうためである。

=== IEEE 802.11n (2009 年)@wi-fi-certification

IEEE 802.11n は、2009 年に策定された。2.4 GHz 帯と 5 GHz 帯の両方を使用でき、最大データ転送速度は 600 Mbps である (MIMO 4x4)。MIMO (Multiple Input Multiple Output) 技術を採用しており、複数のアンテナを使用することで、通信速度と信頼性を向上させている。また、チャネルボンディングという技術により、複数のチャネルを束ねて使用することで、帯域幅を拡大し、高速なデータ転送を実現している。

=== IEEE 802.11ac (2013 年)@wi-fi-certification

IEEE 802.11ac は、2013 年に策定された。5 GHz 帯を使用し、最大データ転送速度は 6.93 Gbps である (MIMO 8x8)。IEEE 802.11ac は、チャネルボンディングをさらに拡張し、最大 160 MHz の帯域幅をサポートしている。また、MU-MIMO (Multi-User MIMO) 技術を採用しており、複数のデバイスに同時にデータを送信できるため、ネットワークの効率が向上している。

=== IEEE 802.11ax (2019 年)@wi-fi-certification

IEEE 802.11ax は、2019 年に策定された。2.4 GHz 帯と 5 GHz 帯の両方を使用でき、最大データ転送速度は 9.6 Gbps である。OFDMA (Orthogonal Frequency Division Multiple Access) 技術を採用しており、複数のデバイスが同時に通信できるため、ネットワークの効率が大幅に向上している。また、ターゲットウェイクタイム (TWT) 機能により、デバイスの省電力化が図られている。さらに、BSS カラーリングという技術により、同一チャネル内での干渉を低減し、通信品質を向上させている。WPA3 セキュリティプロトコルの採用を始め、暗号化に関わる機能も向上している。直交周波数分割多重アクセス (OFDMA) 方式を採用しており、複数のユーザが同時に通信できるため、ネットワークの効率が向上している。

=== IEEE 802.11be (予定)@wi-fi-certification

IEEE 802.11be は、次世代の無線 LAN 規格として策定が進められている。5 GHz 帯と 6 GHz 帯を使用でき、最大データ転送速度は 30 Gbps 以上を目指している。MIMO 技術のさらなる拡張や、チャネルボンディングの強化により、高速なデータ転送を実現する予定である。また、低遅延通信や高密度環境での性能向上も目指しており、IoT デバイスやスマートシティなどの新しい応用分野への対応が期待されている。

== VPN の仕組みと種類について説明せよ

VPN (Virtual Private Network) は、公衆ネットワーク (インターネットなど) を利用して、プライベートネットワークを構築する技術である。VPN は、データの暗号化とトンネリング技術を組み合わせることで、安全な通信を実現している。VPN の主な仕組みと種類について説明する。

=== VPN の仕組み

VPN は、以下のような機能を提供する。

- データの暗号化: VPN は、通信データを暗号化することで、第三者による盗聴や改ざんを防止する。これにより、公衆ネットワーク上での安全な通信が可能となる。

- トンネリング: VPN は、トンネリング技術を使用して、プライベートネットワーク内のデータを公衆ネットワーク上で送信する。トンネルは、仮想的な通信経路を提供し、データが安全に伝送されるようにする。

- 認証: VPN は、ユーザやデバイスの認証を行うことで、不正なアクセスを防止する。これにより、プライベートネットワークへのアクセスが制限される。

- ネットワーク分離: VPN は、プライベートネットワークと公衆ネットワークを分離することで、セキュリティを向上させる。これにより、プライベートネットワーク内のリソースが保護される。

=== VPN の種類

VPN は、主に以下のような種類に分類される。

==== インターネット VPN

インターネット VPN は、公衆インターネットを利用して、プライベートネットワークを構築する VPN である。コスト効率が高く、広範な接続性を提供するため、企業や個人ユーザに広く利用されている。リモートアクセス VPN とサイト間 VPN の両方の形態で提供され、拠点の LAN を繋ぐ LAN 型 VPN と、クライアントコンピュータからネットワークに接続するリモートアクセス型 VPN がある。

==== IP-VPN

IP-VPN (IP Virtual Private Network) は、サービスプロバイダが提供する専用の VPN サービスであり、MPLS (Multiprotocol Label Switching) 技術を使用して、プライベートネットワークを構築する。ISP の閉域網を利用することにより、高いセキュリティと品質を提供すると謳っており、企業の拠点間通信に広く利用されている。IPパケットに「ラベル」を付与し、そのラベル情報に基づいて適切な転送を行うことで、グローバルIPアドレスを必要とせず、事業者閉域網の中で複数の顧客の通信を分離して扱うことができる。

==== 広域イーサネット VPN

広域イーサネット VPN は、イーサネット技術を使用して、広域ネットワーク上でプライベートネットワークを構築する VPN である。イーサネットフレームをそのまま広域ネットワーク上で転送するため、既存のイーサネットインフラストラクチャを活用できる。拠点間通信に広く利用されている。

レイヤ 2 で構築される VPN であるため、ペイロードにはイーサネットフレームがそのまま格納される。そのため、レイヤ 3 パケットのトンネリング通信のみをサポートする VPN よりも、ペイロードに乗せることができるサービスやプロトコルに柔軟性がある。

特に、仮想 LAN カード・ハブと物理 LAN を VPN プロトコルで接続し、その上でブリッジ接続を行うことで、広域イーサネットと同様に、LAN 同士を VPN 経由で接続することが可能となる。


=== VPN プロトコルの種類

VPN プロトコルには、以下のようなプロトコルが存在する。この章では、主にインターネット VPN で使用されるプロトコルについて説明する。

==== IPSec VPN

IPSec (Internet Protocol Security) VPN は、OSI モデルのネットワーク層で動作する VPN 技術である。そもそも、IPSec は、データストリームの各パケットを認証・暗号化し、ネットワーク層で IP 通信を保護するためのプロトコル群であり、特別 VPN のために設計されたプロトコルではない。IPSec VPN は、サイト間 VPN やリモートアクセス VPN に広く利用されている。IPSec は、トンネリングモードとトランスポートモードの両方をサポートしており、柔軟な構成が可能である@cloudflare-ipsec @docomo-ipsec。

==== L2TP VPN

L2TP (Layer 2 Tunneling Protocol) VPN は、OSI モデルのデータリンク層で動作する VPN 技術である。PPP (Point-to-Point Protocol) をトンネリングするためのプロトコルであり、それ自体は、暗号化や秘匿性は提供せず、IPSec と組み合わせて使用して、パケットのデータの暗号化や認証を提供する@l2tp。

==== TLS/SSL VPN

TLS/SSL (Transport Layer Security / Secure Sockets Layer) VPN は、OSI モデルのトランスポート層で動作する VPN 技術である。Web ブラウザを使用してアクセスできるため、クライアントソフトウェアのインストールが不要であり、利便性が高い。@cloudflare-ipsec。

=== ソフトウェア

==== OpenVPN

OpenVPN は、OpenVPN Technologies, Inc. によって開発されているGNU オープンソースの VPN ソフトウェアの一群である@openvpn。事前に共有しておいた秘密鍵、公開鍵証明書、ユーザ名/パスワードを使ってPeer to Peerの相互の認証を行う。内部的にはOpenSSLやSSLv3/TLSv1プロトコルを利用する。Solaris、Linux、OpenBSD、FreeBSD、NetBSD、macOS、Windowsなどで動作するクロスプラットフォームのソフトウェアになっている。TLS/SSL を使用してデータの暗号化と認証を提供し、高いセキュリティを実現している。全ての通信を1つのIPポートに多重化し、UDP（デフォルト、推奨）でもTCPでも利用可能である。ほとんどのプロキシサーバを経由しても大丈夫で、ネットワークアドレス変換経由（いわゆる、NAT 超え）でもファイアウォール経由でも通信可能である。

==== SoftEther VPN

SoftEther VPN は、筑波大学で登大遊らが開発したオープンソースの VPN ソフトウェアであり、OSI モデルのトランスポート層で動作する@softether。多くの VPN プロトコル (L2TP/IPSec、OpenVPN、SSTP など) をサポートしており、高い互換性を持っている。NAT トラバーサル機能を備えており、ファイアウォールや NAT 環境でも容易に接続できる。

#bibliography("refs.yml", full: true)
