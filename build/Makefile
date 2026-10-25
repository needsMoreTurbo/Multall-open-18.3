# Build the Multall-open suite with gfortran. Stagen is patched (fix_stagen.sed) and links
# against no-op plotting stubs.
FC     = gfortran
FFLAGS = -O3 -std=legacy
SRC    = ..

all: multall meangen stagen

multall: $(SRC)/Multall-open-18.3/multall-18.3/multall-open-18.3.f $(SRC)/Multall-open-18.3/multall-18.3/commall-open-18.3
	$(FC) $(FFLAGS) -mcmodel=medium -I$(SRC)/Multall-open-18.3/multall-18.3 -o $@ $<

meangen: $(SRC)/Meangen-17.4/meangen-17.4.f
	$(FC) $(FFLAGS) -o $@ $<

# fix_stagen.sed restores the blade-surface loop that the published source has commented out
Stagen-18.1-fixed.f: $(SRC)/Stagen-18.1/Stagen-18.1.f fix_stagen.sed
	sed -f fix_stagen.sed $< > $@

stagen: Stagen-18.1-fixed.f plot_stubs.f
	$(FC) $(FFLAGS) -o $@ $^

clean:
	rm -f multall meangen stagen Stagen-18.1-fixed.f

.PHONY: all clean
