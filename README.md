# memo_application
Sinatoraを使ったmemoアプリケーション

### アプリの要件整理
- Topページ
  - 画面仕様
    - [追加]ボタンと追加したメモのタイトルリンク一覧を表示
  - クリック挙動
    - メモのタイトルリンク：メモの内容に移動する
    - [追加]ボタン：メモ追加の画面に移動する
- メモ内容画面
  - 画面仕様
    - メモのタイトル、メモの内容、[変更]ボタン、[削除]ボタンを表示
  - ボタンの挙動
    - [変更]ボタン：メモの変更画面に移動
    - [削除]ボタン：メモを削除する
 - メモ入力画面
   - 画面仕様
     - タイトルと内容を入力項目、[保存(変更)]ボタンを表示
     - 新規作成の場合、[保存]ボタンを表示する
     - 変更の場合、[変更]ボタンを表示する
    - ボタンの挙動
      - [保存]ボタン：入力したタイトルと内容を新規作成し保存する
      -  [変更]ボタン：入力したタイトルと内容で既存のメモを変更する

### URL設計
|HTTP動詞|パス|動作|
| --- | --- | --- |
|GET|/memos|全てのメモ一覧を表示する
|GET|/memos/new|新規メモを作成する画面を表示する|
|POST|/memos|新規メモを作成する|
|GET|/memos/:id|特定のメモを表示する|
|GET|/memos/:id/edit|特定のメモを編集する画面を表示する|
|PATCH|/memos/:id|特定のメモを編集する|
|DELETE|/memos/:id|特定のメモを削除する|

### DB
postgresqlを使用する。

####  テーブル作成
```sql
CREATE TABLE memos (
  id      int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  title   varchar(128),
  memo    text
);
```