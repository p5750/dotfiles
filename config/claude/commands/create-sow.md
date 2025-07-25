要件に基づいて、徹底的な影響分析と実装計画を含む包括的な Statement of Work ドキュメントを ultrathink して生成します。

# 要件

$ARGUMENTS

# 手順

要件から以下を抽出します：
1. **主要要件**: 実装すべき主要機能
2. **出力ディレクトリ**（オプション）: SOWファイルの出力先に関する指定がないかを確認します。
3. **追加の制約**: その他の仕様

その後、下記の点に注意して詳細な SOW を作成します：

1. **ファイル名と保存場所**
   - デフォルトのファイル名: SOW.md
   - SOW.md が既に存在する場合、説明的な接尾辞を追加する（例: SOW-機能名.md）
   - 指定されたディレクトリに保存、指定がない場合は現在のディレクトリに保存

2. **不確実性の処理**
   - 曖昧または不明確な要件については、「⚠️ 要明確化」セクションを追加する
   - 回答が必要な具体的な質問を文書化する
   - 該当する場合は代替の解釈を提供する
   - これらの明確化事項をユーザーへの返答にも含める

# 重要な注意事項

- このコマンドは SOW ドキュメントのみを作成し、実際のコードの実装は行いません(.mdファイル以外を編集しない)
- SOW を書く前に必ず徹底的なコードベース分析を実行してください
- 分析中に行った仮定について明示的に記載してください
- 手動でのレビューや調整が必要な領域を強調表示してください
- 技術文書に適した明確で専門的な言葉遣いを使用してください
