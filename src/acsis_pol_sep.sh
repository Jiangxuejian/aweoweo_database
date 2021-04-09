# Note that this script use the REDUCE_SCIENCE_NARROWLINE recipe for the
# pipeline, if you want to use other recipes please change the recipe
# accordingly.
recipe=REDUCE_SCIENCE_NARROWLINE

#!/bin/bash
export STARLINK_DIR=/stardev
source $STARLINK_DIR/etc/profile

oracdr_acsis

# reduce only P0
mkdir p0
ORAC_DATA_IN=$(pwd)
ORAC_DATA_OUT=$(pwd)/p0
# define P1 as "bad receptor"
echo "NW1L NW1U NU1L NU1U NA1L NA1U" >> $ORAC_DATA_OUT/bad_receptors.lis 

oracdr -loop file -file "$ORAC_DATA_IN"/filelist.lis -nodisplay -log sf\
 -verbose -calib bad_receptors=FILE "$recipe"

# reduce only P1
mkdir p1
export ORAC_DATA_IN=$(pwd)
export ORAC_DATA_OUT=$(pwd)/p1
# define P0 as "bad receptor"
echo "NW0L NW0U NU0L NU0L NA0L NA0U" >> $ORAC_DATA_OUT/bad_receptors.lis 

oracdr -loop file -file $ORAC_DATA_IN/filelist.lis -nodisplay -log sf\
 -verbose -calib bad_receptors=FILE "$recipe"
 
# reduce both pol
mkdir both
export ORAC_DATA_IN=$(pwd)
export ORAC_DATA_OUT=$(pwd)/both

oracdr -loop file -file $ORAC_DATA_IN/filelist.lis -nodisplay -log sf\
 -verbose "$recipe"
