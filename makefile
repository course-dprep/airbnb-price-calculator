all: data-preparation analysis price-calculator-app clean

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis
    
price-calculator-app: analysis
	make -C src/price-calculator-app
clean: 
	-rm -r ../../data
	-rm -r ../../gen

