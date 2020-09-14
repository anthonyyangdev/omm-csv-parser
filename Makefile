exe: clean
	dune build canvas_omm.exe
	cp _build/default/canvas_omm.exe omm

exe_path: exe
	python3 setup.py omm

node: clean
	dune build canvas_omm.bc.js
	cp _build/default/canvas_omm.bc.js omm.js
	uglifyjs --compress --mangle --output omm.compressed.js -- omm.js


clean:
	rm -rf _build ./omm ./.merlin ./omm.js ./omm.compressed.js