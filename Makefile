DATE := $(shell date +%Y/%m/%d)

server:
	hugo server -D --disableFastRender
