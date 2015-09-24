PROJECTNAME="WebPonize"

all: prelogue clean build archive epilogue

prelogue:
	@echo ""
	@echo ">>> $(PROJECTNAME) build started"
	@echo ""

clean: webponize.tar.gz
	@xcodebuild clean
	@rm webponize.tar.gz

build:
	@xcodebuild build

archive: ./WebPonize.app
	@tar zcvf webponize.tar.gz ./WebPonize.app

epilogue:
	@echo ""
	@echo ">>> $(PROJECTNAME) build has successfully finished"
	@echo ""

.PHONY: prelogue clean build archive epilogue
