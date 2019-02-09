#use strict;
#use warnings;
#use autodie;
#Suresh Tipirneni 
#Raw autosomal file difference between two

my %data1; my $lines=0;my $nocomm=0;
print "comp  $ARGV[0] $ARGV[1]\n";
open(FILE1, "<", $ARGV[0])
    or die "Failed to open file: $ARGV[0]\n";
while (my $line1 = <FILE1>) {
  $lines++;
#next unless $line1=~/[\s]*rs\S+\s+\S+\s+\S+\s+/;
   chomp $line1;$line1 =~ s/(\s)+/ /g;
   my @linval=split(/\s+/, $line1);
   #print "$linval[0] -> $linval[3]\n";
   if ( $linval[0] =~ /^rs|i/ ) { 
     $data1{$linval[0]} = $linval[3];   
    } else { 
			  #print "discard $line1\n";
	}
}
#print "read $lines\n";
open(FILE2, "<", $ARGV[1])
    or die "Failed to open file: $ARGV[1]\n";
	my $file2num=0;
while (my $line2 = <FILE2>) {
   chomp $line2;$file2num++;
   $line2 =~ s/"//g;
   my @linval2=split(/,/, $line2);
   #print "$linval2[0] -> $linval2[3]\n";
  if ( $linval2[0] =~ /^rs|i/ ) { 
    if (exists $data1{$linval2[0]}) {
          #print "$linval2[0]";
		  my $locdv =$data1{$linval2[0]};
	       $data1{$linval2[0]} = $locdv." - ".$linval2[3];
   } else {
		$nocomm++;
   }
   }
}
my $tmat=0;my $amat=0; my $cmat=0; my $gmat=0;my $nomat=0;
my @tmats=();my @amats=();my @cmats=();my @gmats=();my @nomats=();
for my $key ( keys %data1 ) {
    if (index($data1{$key},'-')>-1) {
	   my @locdatval1 = split('-',$data1{$key});
	   #$locdatval1[1]=~s/C/A/;$locdatval1[1]=~s/T/G/;
	   if (index($locdatval1[1],'A')>-1 and index($locdatval1[0],'A')>-1) {
	      # part match
		  #print  "A match $key -> $locdatval1[0] $locdatval1[1]\n";
		  push @amats,$key;$amat++;
	   } elsif (index($locdatval1[1],'G')>-1 and index($locdatval1[0],'G')>-1) {
	      # part match
		  #print  "G match $key -> $locdatval1[0] $locdatval1[1]\n";
		  push @gmats,$key;$gmat++;
	   } elsif (index($locdatval1[1],'T')>-1 and index($locdatval1[0],'T')>-1) {
	      # part match
		  #print  "T match $key -> $locdatval1[0] $locdatval1[1]\n";
		  push @tmats,$key;$tmat++;
	   }  elsif (index($locdatval1[1],'C')>-1 and index($locdatval1[0],'C')>-1) {
	      # part match
		  #print  "C match $key -> $locdatval1[0] $locdatval1[1]\n";
		  push @cmats,$key;$cmat++;
	   } else {
	     # no match
		# print  "No match $key -> $data1{$key}\n";
		 push @nomats,$key;$nomat++;
	   }
	}
}
close (FILE1);close(FILE2);
print "read $lines file1 $file2num file2 $nocomm not common ".($amat+$gmat+$tmat+$cmat+$nomat)."\n";
print "Total A match $amat -> "."\n";
print "Total G match $gmat -> "."\n";
print "Total T match $tmat -> "."\n";
print "Total C match $cmat -> "."\n";
print "Total No match $nomat -> "."\n";

#print "Total A match $amat -> ".join(",", @amats)."\n";
#print "Total G match $gmat -> ".join(",", @gmats)."\n";
#print "Total T match $tmat -> ".join(",", @tmats)."\n";
#print "Total C match $cmat -> ".join(",", @cmats)."\n";
#print "Total No match $nomat -> ".join(",", @nomats)."\n";