# makefile_template
makefileのテンプレート。  
* Windows で動作確認済み。  
  使用ソフト VisualStudioCode + MinGW
* オブジェクト(.o)は対象ソースのフォルダ階層にかかわらず、常に同じフォルダに出力する

## 構成
	│  makefile
	│
	├─ .vscode : VisualStudioCode用の設定
	│  launch.json
	│  tasks.json
	│
	├─ obj
	│  実行ファイル.exe
	│  依存関係ファイル.d
	│  オブジェクト.o
	│
	└─ src : ソース/ヘッダの例
	  │  main.c
	  ├─inc
	  │  test1.h
	  ├─inc2
	  │  test2.h
	  └─test
	     test.c
