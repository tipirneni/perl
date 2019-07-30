use strict;
use warnings; 

# convert a list of values to sorted value by list
# eg 1 AA AA1,AA2
# will be printed as 
# AA1 => 1 AA
# AA2 => 1 AA
# Suresh Tipirneni

use Data::Dumper;
my $file = "temp.txt";

# Use the open() function to open the file.
unless(open FILE, $file) {
    # Die with error message 
    # if we can't open it.
    die "\nUnable to open $file\n";
}

# Read the file one line at a time.
my @ar1=();my %allar1;
while(my $line = <FILE>) {
    # We'll just print the line for now.
    chomp $line;
	$line=~s/,/ /g;$line=~s/  / /g;$line =~ s/(\d+) (.*)/$2/g;
	my @myarray = split / /,$line;
	#print $line."\n";
	my $arind=$myarray[0];
	#print $arind . "one \n";
	push @ar1,$arind;shift @myarray;
	my $arlen = scalar @myarray;
	#print $arind."->".$arlen."\n" if $arlen>0;
	if ($arlen>0) {
	  foreach my $one (@myarray) {
		if (exists $allar1{$one}) {
	#		print "exists";
			push @{$allar1{$one}},$arind;
		} else { $allar1{$one}=[$arind];}
	} }
}

# close the file.
close FILE;
#print Dumper(\%allar1);
print "$_ => ". scalar(@{$allar1{$_}}). " - " .join(',', @{ $allar1{$_} }) ." \n" for (sort keys %allar1);