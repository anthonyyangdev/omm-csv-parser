main:
	dune build canvas_omm.exe
	cp _build/default/canvas_omm.exe omm

path: clean main
	mv ./omm /usr/local/bin

clean:
	rm -rf _build ./omm