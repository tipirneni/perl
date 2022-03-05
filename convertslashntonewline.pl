#Suresh Tipirneni 
#convert error \n to newline in a file
my $read;
open(FILE, "$ARGV[0]") || die "Can't open $ARGV[0]!";
open(my $fh, '>', "$ARGV[0].new") or die "Could not open file '$ARGV[0]' $!";
my $pc1='';
while ($read = read FILE, $char, 1) {
    if ($pc1 eq '\\' && $char eq 'n') {  print $fh "\n"; $char='';}
    else { print $fh "$pc1"; }
    $pc1=$char;
}
print $fh $pc1;
close $fh;
