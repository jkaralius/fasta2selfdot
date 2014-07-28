#!/usr/bin/perl

=pod

=head1 fasta2selfdot.pl

=head1 USAGE

fasta2selfdot.pl /path/to/sequence.fasta


=head1 AUTHOR

Joseph Karalius
https://github.com/jkaralius


=cut



use strict;
use warnings;

use Bio::SeqIO;
use Getopt::Long;

my $file = shift;
chomp $file;

my $nozoom = 1;
my $maxbin = 1000000;
my $maxwidth  = 1200;
my $maxheight = 1200;

# Enter path to geparcmd.sh
my $gepardcmd = '/home/UNIXHOME/jkaralius/src/gepard-1.30/gepardcmd.sh';

#Enter path to edna.mat
my $mat = '/home/UNIXHOME/jkaralius/src/gepard-1.30/matrices/edna.mat';

my $in = Bio::SeqIO->new(-file => $file);

mkdir 'dot';

while (my $seq = $in->next_seq()){
    
    my $seqid = $seq->id;
    $seqid =~ s/\W+/_/g;
    my $seqlen = $seq->length;
    print STDERR $seqlen, "\n";

    my $outfile = "$seqid\.fa";
    my $out = Bio::SeqIO->new(-file => ">$outfile" ,
	                  	      -format => 'FASTA');
        
    print STDERR $seq->id, "\t", $seq->length, "\t", $outfile, "\n";
    $out->write_seq($seq);

    
    my $seq1 = $outfile;
    my $seq2 = $outfile;
    my $zoom = int($seqlen/10000);
    if ($zoom < 30){
        $zoom = 30;
    }
    my $word   = 10;
    my $window = 0;

    
    my $png = "./dot/$outfile\.png";
    	
    #my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -maxwidth $maxwidth -maxheight $maxheight -word $word -window $window -outfile $png";
	my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -zoom $zoom -word $word -window $window -outfile $png";
	#my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -word $word -window $window -outfile $png";
    print STDERR $cmd, "\n";
    `$cmd`;
    
}
