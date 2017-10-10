#########################################
#        VMD SPICE RACK
#        14 NOV 2014
########################################

# Calling SPICERACK gives a list of all scripts
# included in this package and their functions
proc spicerack {} {

puts "GARLIC"
puts "	Show protein in "
puts "	  New Cartoon/Secondary Structure"
puts "	  and show ligands in Licorice"
puts "LICORICE"
puts "	Show ligands in Licorice"
puts "SUGAR"
puts "	Show hydrogen bonds near ligand"
puts "	 and show nearby residues"
puts "CHAI"
puts "	Show protein in "
puts "	 New Cartoon/Secondary Structure"
puts "GINGER"
puts "	Batch load trajectory files"
puts "ANISE"
puts "	Get bond lengths by inputting atom selections."
puts "	 Put two atom selections in quotes"
puts "	 just like in the graphics window."
}


#########CHAI######################
# Show protein in New Cartoon/Secondary Structure

# Changes the first representation to New Cart/SS
proc chai {} {
mol modselect 0 top protein
mol modcolor 0 top Structure
mol modstyle 0 top NewCartoon 0.300000 10.000000 4.100000 0
}

# Creates new representation as New Cart/SS
proc fresh-chai {} {
mol color Structure
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol selection protein
mol material Opaque
mol addrep top
}

##############GARLIC#####################3
# Show protein in New Cartoon/Secondary Structure
# and show ligands in Licorice

# Will over-write existing representations
proc garlic { { id "top" } } {
if { $id eq "top" } {
	puts "Representations will be applied to active molecule"
	puts "Usage: garlic <molecule id>"
}

mol modselect 0 $id protein
mol modcolor 0 $id Structure
mol modstyle 0 $id NewCartoon 0.300000 10.000000 4.100000 0
if { [molinfo $id get numreps] >= 2 } {
	mol modselect 1 $id not protein
	mol modcolor 1 $id Name
	mol modstyle 1 $id Licorice 0.300000 10.000000 10.000000
	} else {
	mol selection not protein
	mol color Name
	mol representation Licorice 0.300000 10.000000 10.000000
	mol addrep $id
}
}

# Will make new representation
proc fresh-garlic { { id "top" } {rockaxis "none"} } {
if { $id eq "top" } {
	puts "Representations will be applied to active molecule"
	puts "Usage: garlic <molecule id>"
}

mol selection protein
mol color Structure
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol addrep $id
mol selection not protein
mol color Name
mol representation Licorice 0.300000 10.000000 10.000000
mol addrep $id

# Optional fancy spinnnzzzz...
if { $rockaxis ne "none" } {
display resetview
rock $rockaxis by 0.25 100
}
}

############GINGER###########
# Batch load trajectory files

proc ginger { root starti endi { molid "top" } } {
# Need to add real usage message here.
if { $root eq "" } {
	puts "Batch load .dcd trajectory files"
	puts "Usage: ginger <root file name> <start index> <end index> [<molecule id>]"
	exit 1
}
set x $starti
while {$x<=$endi} {
	mol addfile $root$x.dcd type {dcd} step 1 waitfor all molid $molid
	incr x
 }
 
# This will make it easier to see animation
menu rmsdvt on
}

##########LICORICE##########
# Show ligands in Licorice
# Creates a new representation

proc licorice {} {
mol color Name
mol representation Licorice 0.300000 10.000000 10.000000
mol selection not protein
mol material Opaque
mol addrep top
}

############SUGAR###########
# Show hydrogen bonds near ligands
# Creates a new representation

proc sugar {} {
# Create HBond rep
mol color ColorID 3
mol representation HBonds 3.000000 20.000000 3.000000
mol selection {same residue as within 3 of not protein}
mol material Opaque
mol addrep top
# Create licorice rep for nearby residues
mol color ResName
mol representation Licorice 0.100000 10.000000 10.000000
mol selection {same residue as within 3 of not protein}
mol material Opaque
mol addrep top
}

##################ANISE####################
# Get bond lengths by inputting atom selections.
#  Put two atom selections in quotes
#  just like in the graphics window.

proc anise { atom1 atom2 } {

set idx [ molinfo top ]
set sel1 [atomselect $idx $atom1 ]
set sel2 [atomselect $idx $atom2 ]
set sel1i [ $sel1 get index ]
set sel2i [ $sel2 get index ]
label add Atoms $idx/$sel1i
label add Atoms $idx/$sel2i 
label add Bonds $idx/$sel1i $idx/$sel2i

menu labels on
}