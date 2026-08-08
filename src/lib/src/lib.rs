// Snippet library.
//
// Tag functions/structs with #[snippet("name")] and run `scripts/gen-snippets.sh`
// (or `cargo snippet -t vscode` from this directory) to regenerate
// .vscode/rust.code-snippets.
//
// Example:
//
// use cargo_snippet::snippet;
//
// #[snippet("gcd")]
// fn gcd(a: u64, b: u64) -> u64 {
//     if b == 0 { a } else { gcd(b, a % b) }
// }
