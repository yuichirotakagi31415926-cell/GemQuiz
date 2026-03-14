# GemQuiz 要件定義書

## 1. プロジェクト概要

| 項目 | 内容 |
|-----|-----|
| アプリ名 | GemQuiz（仮） |
| プラットフォーム | iOS |
| 開発言語 | Swift / SwiftUI |
| 対象OS | iOS 17以上 |
| 開発環境 | Xcode + VSCode |
| リリース形態 | App Store |

### コンセプト

> 宝石の基礎から専門知識まで、段階的に深く学べるクイズアプリ

入門レベルから上級・専門レベルまで幅広い難易度の問題を提供し、
宝石に興味を持ち始めた人から、深く知識を追求したい人まで楽しめるクイズアプリ。

---

## 2. ターゲットユーザー

| ユーザー層 | 特徴 |
|-----------|-----|
| 入門者 | 宝石に興味を持ち始めた。誕生石・有名宝石を知りたい |
| 中級者 | 宝石を好きで、産地・特性など深い知識を身につけたい |
| 上級者 | 宝石学の専門知識（屈折率・結晶系・処理の見分け方など）まで理解したい |

---

## 3. 難易度定義

| レベル | 表示 | 内容例 |
|-------|-----|-------|
| 1 | ★☆☆☆ 入門 | ダイヤモンドの硬度・誕生石・有名な宝石の名前 |
| 2 | ★★☆☆ 初級 | 鉱物種・基本的な特性・代表的な産地 |
| 3 | ★★★☆ 中級 | 処理の種類・包有物・二色性・宝石ごとの詳細特性 |
| 4 | ★★★★ 上級 | 屈折率・比重の数値・結晶系・産地ごとの特徴の違い・鑑別法 |

---

## 4. 問題カテゴリ

| カテゴリID | カテゴリ名 | 内容 |
|----------|-----------|-----|
| `diamond` | ダイヤモンド | 4C・結晶構造・処理・蛍光性 |
| `corundum` | コランダム | ルビー・サファイアの特性・産地・処理 |
| `beryl` | ベリル | エメラルド・アクアマリン・モルガナイト等 |
| `quartz` | クォーツ | アメジスト・シトリン・ローズクォーツ等 |
| `precious` | 宝石基礎 | 全宝石共通の基礎知識・宝石の定義 |
| `gemology` | 宝石学 | 屈折率・比重・結晶系・光学的性質 |
| `origin` | 産地・歴史 | 世界の産地・宝石にまつわる歴史・伝説 |
| `treatment` | 処理・合成 | 加熱・含浸・コーティング・合成石の見分け方 |

---

## 5. 問題形式

| 形式 | 説明 | 難易度帯 |
|-----|-----|--------|
| 4択選択 | 選択肢4つから1つを選ぶ | 全難易度 |
| 画像問題 | 宝石の写真を見て名前・特性を答える | 入門〜中級 |
| 数値穴埋め | 硬度・屈折率・比重などの数値を4択から選ぶ | 中級〜上級 |

---

## 6. 問題データ仕様

### JSONフォーマット

```json
{
  "id": "gem_001",
  "category": "diamond",
  "difficulty": 1,
  "type": "multiple_choice",
  "question": "ダイヤモンドのモース硬度はいくつですか？",
  "options": ["8", "9", "10", "7"],
  "correct_index": 2,
  "explanation": "ダイヤモンドはモース硬度10で、天然鉱物の中で最も硬い物質です。",
  "image_name": null,
  "tags": ["hardness", "basic", "diamond"]
}
```

### フィールド定義

| フィールド | 型 | 必須 | 説明 |
|-----------|---|-----|-----|
| `id` | String | ✓ | 一意なID（`カテゴリ_連番`） |
| `category` | String | ✓ | カテゴリID（上記カテゴリ参照） |
| `difficulty` | Int (1〜4) | ✓ | 難易度レベル |
| `type` | String | ✓ | `multiple_choice` のみ（現状） |
| `question` | String | ✓ | 問題文 |
| `options` | [String] | ✓ | 選択肢（4つ） |
| `correct_index` | Int (0〜3) | ✓ | 正解のインデックス |
| `explanation` | String | ✓ | 解説文 |
| `image_name` | String? | | 画像ファイル名（不要ならnull） |
| `tags` | [String] | | 検索・フィルタ用タグ |

### ファイル構成

```
Resources/questions/
├── diamond.json
├── corundum.json
├── beryl.json
├── quartz.json
├── precious.json
├── gemology.json
├── origin.json
└── treatment.json
```

---

## 7. 画面設計

### 7.1 画面一覧

| 画面ID | 画面名 | 概要 |
|-------|-------|-----|
| S-01 | ホーム画面 | モード・難易度・問題数を選択してクイズを開始 |
| S-02 | クイズ画面 | 問題を表示し回答を受け付ける |
| S-03 | 解説画面 | 正誤フィードバックと解説を表示 |
| S-04 | 結果画面 | セッション終了時のスコアと結果サマリー |
| S-05 | 統計画面 | 正解率・弱点・履歴を確認 |
| S-06 | 復習画面 | 間違えた問題を再出題 |

---

### S-01 ホーム画面

**役割：** クイズのセッション設定を行い、スタートする起点

**表示要素：**
- アプリタイトル・ロゴ
- モード選択
  - 通常モード（難易度・カテゴリを指定）
  - ランダムモード（全難易度・全カテゴリ混合）
  - 復習モード（過去に間違えた問題のみ）
- 難易度選択（通常モード時）：入門 / 初級 / 中級 / 上級 / すべて
- カテゴリ選択（通常モード時）：カテゴリ一覧からマルチ選択
- 問題数選択：10問 / 20問 / 30問
- タイマー設定：ON（20秒） / OFF
- スタートボタン
- 統計画面への導線（右上アイコン or タブ）

---

### S-02 クイズ画面

**役割：** 問題を1問ずつ表示し、ユーザーの回答を受け付ける

**表示要素：**
- 進捗バー（例：3/10問）
- 問題番号・難易度バッジ（★の数）
- カテゴリラベル
- 問題文
- 宝石画像（画像問題の場合）
- 選択肢ボタン × 4
- タイマー（ON時）：残り秒数をプログレスバーで表示
- 現在のスコア

**動作：**
- 選択肢タップ → 即座に正誤を色で表示（正解：緑 / 不正解：赤）
- 正解選択肢をハイライト表示（不正解時も正解を表示）
- 0.8秒後に解説画面へ自動遷移
- タイマー切れ → 時間切れ扱いで不正解・解説画面へ遷移

---

### S-03 解説画面

**役割：** 正誤フィードバックと解説を見せて理解を深める

**表示要素：**
- 正解 / 不正解 表示（アイコン＋テキスト）
- 正解の選択肢
- 解説テキスト
- 宝石の豆知識（あれば）
- 「次の問題へ」ボタン
- （最終問題の場合）「結果を見る」ボタン

---

### S-04 結果画面

**役割：** セッションの結果を表示し、振り返りを促す

**表示要素：**
- スコア（例：7 / 10問正解）
- 正解率（%）
- 難易度別正解数の内訳
- かかった時間（タイマーON時）
- 間違えた問題の一覧（問題文と正解をリスト表示）
- ボタン類
  - 「もう一度同じ設定でプレイ」
  - 「間違えた問題を復習」
  - 「ホームに戻る」

---

### S-05 統計画面

**役割：** 累積の学習データを可視化する

**表示要素：**
- 総回答数・総正解数・総合正解率
- 難易度別正解率（バー or チャート）
- カテゴリ別正解率（バー or チャート）
- 連続正解ストリーク（最高・現在）
- 復習リストの問題数（未復習のもの）

---

### S-06 復習画面

**役割：** 過去に間違えた問題を再出題し、弱点を克服する

**表示要素・動作：**
- S-02（クイズ画面）と同じUI
- 問題プールは「過去に1回以上不正解の問題」
- 正解したら復習リストから除外する（設定でON/OFF可）

---

## 8. データモデル（Swift）

```swift
// 問題モデル
struct Question: Codable, Identifiable {
    let id: String
    let category: String
    let difficulty: Int
    let type: String
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let imageName: String?
    let tags: [String]
}

// クイズセッション
struct QuizSession {
    let questions: [Question]
    var currentIndex: Int = 0
    var answers: [Int?] = []  // nil = 未回答、Int = 選択した選択肢インデックス
    var startedAt: Date = Date()
}

// 回答履歴（永続化）
struct AnswerRecord: Codable {
    let questionId: String
    let isCorrect: Bool
    let answeredAt: Date
}
```

---

## 9. 技術スタック

| 項目 | 採用技術 |
|-----|--------|
| UI | SwiftUI |
| 状態管理 | `@Observable` (iOS 17+) |
| 問題データ | JSON（Bundle内同梱） |
| 永続化 | UserDefaults（進捗・設定） |
| 画像 | Assets.xcassets |

---

## 10. プロジェクト構成

```
GemQuiz/
├── App/
│   └── GemQuizApp.swift
├── Models/
│   ├── Question.swift
│   ├── QuizSession.swift
│   └── AnswerRecord.swift
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── QuizViewModel.swift
│   └── StatsViewModel.swift
├── Views/
│   ├── Home/
│   │   └── HomeView.swift
│   ├── Quiz/
│   │   ├── QuizView.swift
│   │   ├── QuestionCardView.swift
│   │   └── AnswerButtonView.swift
│   ├── Explanation/
│   │   └── ExplanationView.swift
│   ├── Result/
│   │   └── ResultView.swift
│   ├── Stats/
│   │   └── StatsView.swift
│   └── Review/
│       └── ReviewView.swift
├── Services/
│   ├── QuestionLoader.swift
│   └── ProgressStore.swift
└── Resources/
    └── questions/
        ├── diamond.json
        ├── corundum.json
        ├── beryl.json
        ├── quartz.json
        ├── precious.json
        ├── gemology.json
        ├── origin.json
        └── treatment.json
```

---

## 11. マネタイズ（案）

| 収益源 | 内容 |
|-------|-----|
| フリーミアム | 無料：1日10問まで・入門〜初級のみ |
| プレミアム（月額 or 買い切り） | 無制限・全難易度・統計機能フル開放 |
| 広告（無料版） | 結果画面にバナー広告 |

> ※マネタイズ方針は開発後半で決定予定

---

## 12. 開発ロードマップ

| フェーズ | 内容 | 目標 |
|--------|-----|-----|
| Phase 1（MVP） | 問題JSON作成・クイズ基本動作・解説表示 | 動くプロトタイプ |
| Phase 2 | 統計・復習機能・ゲーミフィケーション | 継続利用できる品質 |
| Phase 3 | UI磨き・App Store申請 | リリース |

---

## 13. 未決定事項

- [ ] アプリ正式名称
- [ ] アイコン・カラーパレット等のデザイン
- [ ] マネタイズ方針（フリーミアム or 有料 or 広告）
- [ ] 問題の総数目標
- [ ] タイマーのデフォルト秒数
