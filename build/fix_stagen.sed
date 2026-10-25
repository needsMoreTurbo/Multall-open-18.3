# Stagen-18.1.f as published has the loop that interpolates the blade surfaces onto the
# output points (DO 55) commented out, together with the trailing-edge plot arrays (DO 333).
# YSIN is then never set and every blade is written with zero camber (a flat plate in
# r-theta). Restore both loops; labels go back into columns 1-5.
1469,1474s/^C/ /
1476,1477s/^C/ /
1483,1488s/^C/ /
1489s/^C    55 CONTINUE/   55 CONTINUE/
1490,1491s/^C/ /
1492s/^C   889 FORMAT/  889 FORMAT/
1503,1508s/^C/ /
1509s/^C   333 CONTINUE/  333 CONTINUE/
1510s/^C/ /
