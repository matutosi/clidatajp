# clidatajp プロジェクト

## check の生成物の後始末

- **`R CMD check` などで作られる `*.tar.gz` は，役割が終わったら削除する**．
  結果を確認し終えたら (CRAN へ出す場合は提出が済んだら) 消してよい．
  DESCRIPTION とソースから何度でも作り直せるため，残しておく理由がない．
- 同じ理由で，`*.Rcheck/` (check の作業ディレクトリ) も確認が済んだら消す．
- 補足: `*.tar.gz` を作るのは `R CMD build` / `devtools::build()` で，
  `devtools::check()` は既定で一時ディレクトリに作るためプロジェクト直下には残らない．
  プロジェクト直下に残るのは `R CMD build` を直接実行したときが多い．
  どちらの経路でできたものでも，見つけたら消す．

## 進捗状況

### 現在の状態

- 2026-08-26 18:42
  **`develop` の 4 コミットを `main` へ merge して push した** (fast-forward)．
  差分は README の導入手順・`str_remove()` 化・バグ修正・CLAUDE.md 追加．

- 2026-08-26 18:42
  **NEWS.md を実態に合わせ，版を 0.5.3 にした**．`wi()`・`ci()` は実装・export 済みなので
  TODO から外して 0.5.3 の節に記載．残る TODO は「JMA の詳細データのダウンロード関数」1 件．

### 次にやること

- **JMA の詳細データをダウンロードする関数を実装する** (NEWS の残る TODO)．
- 0.5.3 を CRAN へ出すかは未定 (出すなら `R CMD check` と `cran-comments.md` の更新が要る)．
