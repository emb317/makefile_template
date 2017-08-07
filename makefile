# オブジェクトの出力先
OUTDIR := obj

# 実行ファイル名
PROG := $(OUTDIR)/a.exe

# インクルードパス
INCDIR += src/inc
INCDIR += src/inc2

# ソース (ファイルパスを指定する)
SRC += src/main.c
# ソース (特定のフォルダ内すべてをコンパイル対象とする場合)
SRC += src/test/*.c

# 使用するコンパイラ
CC = gcc
# コンパイルオプション
CFLAGS += -Wall
CFLAGS += -O2
CFLAGS += $(addprefix -I ,$(INCDIR))
CFLAGS += -g

# Windowsにsedが無いのでGitので代用
SED = "C:\Program Files\Git\usr\bin\sed.exe"

# ------ ここより下は変更しないこと! ------

# 対象ソース -> src/main.c src/test/test.c
SRCS := $(wildcard $(SRC))
# 出力オブジェクト -> obj/main.o obj/test.o
OBJS := $(addprefix $(OUTDIR)/,$(notdir $(patsubst %.c,%.o,$(SRCS))))
# 依存関係ファイル -> obj/main.d obj/test.d
DEPS := $(addprefix $(OUTDIR)/,$(notdir $(patsubst %.c,%.d,$(SRCS))))
# 探索パス -> obj src src/test
VPATH = $(OUTDIR) $(dir $(SRCS))

# 実行ファイル作成 (リンク)
$(PROG): $(OBJS) $(DEPS)
	$(CC) -o $@ $(OBJS)

# 依存関係ファイル作成
$(OUTDIR)/%.d:%.c
#	参照しているヘッダを依存関係ファイルに出力
#	ヘッダを変更した際にオブジェクトと依存関係ファイルが両方更新されるよう2行出力する
#	obj/main.d: src/main.c src/inc/test1.h src/inc2/test2.h
#	obj/main.o: src/main.c src/inc/test1.h src/inc2/test2.h
	@cmd.exe /C "if not exist $(OUTDIR) mkdir $(OUTDIR)"
	$(CC) $(CFLAGS) -MM $< | $(SED) -e 's!$(subst .d,.o,$(notdir $@))!$@!' > $@
	$(CC) $(CFLAGS) -MM $< | $(SED) -e 's!$(subst .d,.o,$(notdir $@))!$(subst .d,.o,$@)!' >> $@

# オブジェクト作成 (コンパイル)
$(OUTDIR)/%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<

.PHONY : clean
clean :
	cmd.exe /C "del $(subst /,\,$(PROG)) $(subst /,\,$(OBJS)) $(subst /,\,$(DEPS))"

# 依存関係ファイルの読み込み
-include $(DEPS)
