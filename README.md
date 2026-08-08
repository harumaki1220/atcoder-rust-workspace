# AtCoder Rust Workspace

AtCoderの問題を解くためのRustワークスペース。

- [cargo-compete](https://github.com/qryxip/cargo-compete): サンプルケースの取得、ローカル実行、提出を行う。
- [cargo-snippet](https://github.com/hatoo/cargo-snippet): `src/lib`にタグ付けしたコードをVSCodeのスニペットに変換する。
- ツールチェイン(AtCoderジャッジと同じバージョンのrustc、および cargo-compete/cargo-snippet)は[Nix](https://nixos.org/)で宣言的に用意する。

## 前提

- [Nix](https://nixos.org/download/)(flakesを有効化していること)
- [Visual Studio Code](https://code.visualstudio.com/)(任意。rust-analyzer + スニペット用)

## セットアップ

```bash
nix develop
```

初回実行時に`cargo-compete`と`cargo-snippet`を`~/.cargo/bin`にインストールする(次回以降はスキップされる)。固定された`rustc`が使えるシェルに入る。

`compete.toml`の依存クレート一覧と`[submit] language_id`は、AtCoder公式の[言語・ライブラリ一覧](https://img.atcoder.jp/file/language-update/2025-10/language-list.html)に合わせてある。AtCoderのジャッジがアップデートされたら、このページを確認し直して`flake.nix`の`rustVersion`と`compete.toml`の値を更新すること。

## ログイン

セッションが切れた時などに、その都度実行する:

```bash
scripts/login.sh
```

## コンテストを解く

```bash
scripts/new-contest.sh abc317      # src/contest/abc317 を作成し、サンプルケースを取得 rust-analyzerにも登録する
cd src/contest/abc317
cargo compete test a
cargo compete submit a
```

## スニペット

`src/lib/src/lib.rs`(またはそのサブモジュール)に再利用したいコードを書き、タグを付ける:

```rust
use cargo_snippet::snippet;

#[snippet("gcd")]
fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { gcd(b, a % b) }
}
```

VSCodeスニペットを再生成する:

```bash
scripts/gen-snippets.sh
```

`.vscode/rust.code-snippets`に出力される(gitignore済み、ローカルのみ)。

## スクリプト

- `scripts/new-contest.sh <contest>` — `cargo compete new` + rust-analyzerへの登録
- `scripts/gen-snippets.sh` — `src/lib`から`.vscode/rust.code-snippets`を再生成
- `scripts/login.sh [site]` — `cargo compete login`

初回だけ`chmod +x scripts/*.sh`で実行権限を付けるか、`bash scripts/<name>.sh`で実行する。

## ライセンス

[LICENSE](LICENSE)
