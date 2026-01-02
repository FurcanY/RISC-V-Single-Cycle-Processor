# Kaynak Dosyalarının Tanımı
SV_FILES  := $(wildcard ./src/pkg/*.sv) $(wildcard ./src/rtl/*.sv)
ALL_TB    := $(wildcard ./tb/*.sv)
ALL_FILES := ${SV_FILES} ${ALL_TB}

# Varsayılan Testbench (TB= ile override edilebilir)
TB        ?= obsidyen_core_tb
TOP       := $(TB)
TB_FILE   := ./tb/$(TB).sv


PKG_FILES := $(wildcard ./src/pkg/*.sv)
RTL_ONLY  := $(wildcard ./src/rtl/*.sv)
RTL_FILES := $(PKG_FILES) $(RTL_ONLY)

# Varsayılan Top Module (sentez için)
TOP_MODULE ?= obsidyen_core  # Sentez için top modülünüzün adı

# SENTEZ KONTROLÜ - Sadece RTL dosyalarını kontrol et
synth:
	@echo "▶ SENTEZ KONTROLÜ BAŞLATILIYOR (Sadece RTL)"
	@echo "📁 Kontrol edilen dosyalar:"
	@for file in $(RTL_FILES); do echo "   $$file"; done
	@echo "🏗️  Top Module: $(TOP_MODULE)"
	@echo ""
	verilator \
		--lint-only \
		--top-module $(TOP_MODULE) \
		-Wall \
		--assert \
		-Wno-CASEINCOMPLETE \
		-Wno-MULTIDRIVEN \
		-Wno-WIDTH \
		-Wno-UNOPTFLAT \
		-Wno-STMTDLY \
		-Wno-ASSIGNDLY \
		-Wno-LATCH \
		-Wno-IMPLICIT \
		-Wno-style \
		$(RTL_FILES)
	@echo ""
	@echo "✅ Sentez kontrolü BAŞARIYLA tamamlandı!"
	@echo "   Sadece RTL dosyaları kontrol edildi (TB dosyaları hariç)"


# Belirli bir modül için sentez kontrolü
synth-module:
	@echo "▶ MODÜL BAZLI SENTEZ KONTROLÜ"
	@echo "Kullanım: make synth-module MODULE=module_name"
	@echo ""
	@if [ -z "$(MODULE)" ]; then \
	  echo "❌ HATA: MODULE parametresi gerekli!"; \
	  echo "Örnek: make synth-module MODULE=alu"; \
	  exit 1; \
	fi
	@echo "🔍 Kontrol edilen modül: $(MODULE)"
	verilator \
		--lint-only \
		--top-module $(MODULE) \
		-Wall \
		--assert \
		-Wno-CASEINCOMPLETE \
		-Wno-MULTIDRIVEN \
		-Wno-WIDTH \
		-Wno-UNOPTFLAT \
		-Wno-STMTDLY \
		-Wno-ASSIGNDLY \
		-Wno-LATCH \
		-Wno-IMPLICIT \
		-Wno-style \
		$(RTL_FILES)


# Lint
lint:
	@echo "▶ Lint calistiriliyor"
	@if verilator --lint-only -Wall --timing -Wno-UNUSED --top-module $(TB) -Wno-CASEINCOMPLETE -Wno-MULTIDRIVEN $(ALL_FILES); then \
	  echo "ERROR YOK !"; \
	else \
	  exit 1; \
	fi


# Build
build:
	@if [ ! -f $(TB_FILE) ]; then \
	  echo "❌ HATA: Testbench dosyası '$(TB_FILE)' bulunamadı!"; \
	  exit 1; \
	fi
	@echo "▶ Build ediliyor: $(TB_FILE)"
	verilator --assert --binary $(SV_FILES) $(TB_FILE) --top $(TOP) -j 0 --trace -Wno-CASEINCOMPLETE -Wno-MULTIDRIVEN


# Simülasyon Çalıştır
run: build
	@echo "▶ Simülasyon baslatiliyor"
	obj_dir/V$(TOP)


# Waveform Aç
wave: run
	@echo "▶ GTKWave aciliyor"
	echo $PATH
	which gtkwave
	/usr/bin/gtkwave dumb.vcd

# Temizlik
clean:
	@echo "temp dosyalar siliniyor"
	@rm -f dump.vcd
	@rm -rf obj_dir
	@echo "temp dosyalar silindi"


# Yardımcı Bilgiler
help:
	@echo "--------------------------------------------------"
	@echo "  make synth                   - Tüm RTL sentez kontrolü"
	@echo "  make synth-module MODULE=ad  - Belirli modül kontrolü"
	@echo "                                                   "
	@echo "  TB=modul_tb -> Kullanmak istediğin testbench adi"
	@echo "  make lint TB=modul_tb   -> sadece lint kontrol"
	@echo "  make build TB=modul_tb  -> sadece derle"
	@echo "  make run TB=modul_tb    -> derle ve calistir"
	@echo "  make wave TB=modul_tb   -> waveform görüntüle"
	@echo "  make clean              -> tüm geçici dosyalari sil"
	@echo "--------------------------------------------------"
