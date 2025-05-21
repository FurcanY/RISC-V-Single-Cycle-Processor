# ========================
# Kaynak Dosyalarının Tanımı
# ========================
SV_FILES  := $(wildcard ./src/pkg/*.sv) $(wildcard ./src/rtl/*.sv)
ALL_TB    := $(wildcard ./tb/*.sv)
ALL_FILES := ${SV_FILES} ${ALL_TB}
# ========================
# Varsayılan Testbench (TB= ile override edilebilir)
# ========================
TB        ?= alu_tb
TOP       := $(TB)
TB_FILE   := ./tb/$(TB).sv

# ========================
# Lint
# ========================
lint:
	@echo "▶ Lint kontrolü yapılıyor..."
	verilator --lint-only -Wall --timing -Wno-UNUSED --top-module $(TB) -Wno-CASEINCOMPLETE -Wno-MULTIDRIVEN $(ALL_FILES)

# ========================
# Build
# ========================
build:
	@if [ ! -f $(TB_FILE) ]; then \
	  echo "❌ HATA: Testbench dosyası '$(TB_FILE)' bulunamadı!"; \
	  exit 1; \
	fi
	@echo "▶ Build ediliyor: $(TB_FILE)"
	verilator --binary $(SV_FILES) $(TB_FILE) --top $(TOP) -j 0 --trace -Wno-CASEINCOMPLETE -Wno-MULTIDRIVEN

# ========================
# Simülasyon Çalıştır
# ========================
run: build
	@echo "▶ Simülasyon başlatılıyor..."
	obj_dir/V$(TOP)

# ========================
# Waveform Aç
# ========================
wave: run
	@echo "▶ GTKWave açılıyor..."
	echo $PATH
	which gtkwave
	/usr/bin/gtkwave dumb.vcd
# ========================
# Temizlik
# ========================
clean:
	@echo "🧹 temp dosyalar siliniyor"
	@rm -f dump.vcd
	@rm -rf obj_dir
	@echo "✅ temp dosyalar silindi"

# ========================
# Yardımcı Bilgi
# ========================
help:
	@echo "--------------------------------------------------"
	@echo "  TB=modul_tb -> Kullanmak istediğin testbench adı"
	@echo "  make build TB=modul_tb  -> sadece derle"
	@echo "  make run TB=modul_tb    -> derle ve çalıştır"
	@echo "  make wave TB=modul_tb   -> waveform görüntüle"
	@echo "  make clean              -> tüm geçici dosyaları sil"
	@echo "--------------------------------------------------"

