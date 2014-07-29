#!/usr/bin/perl

=pod

=head1 fasta2selfdot.pl

=head1 TITLE

fasta2selfdot

=head1 DESCRIPTION

Script takes a multi-FASTA or FASTQ file input and breaks it up into single sequence files, then runs self-by-self dot plots with Gepard <http://http://www.helmholtz-muenchen.de/icb/software/gepard/index.html>

Outputs all single-sequence FASTA files into directory "./seq", and dot plots go into "./dot".

=head1 PREREQUISITES

Gepard
Bioperl

=head1 USAGE

fasta2selfdot.pl -i /path/to/sequence.fasta



=head2 Options

 -i : /path/to/input/seqfile


=head1 AUTHOR

Joey Karalius

https://github.com/jkaralius

=head1 ISSUES

Report all issues to:

https://github.com/jkaralius/fasta2selfdot/issues
 
=cut



use strict;
use warnings;

use Bio::SeqIO;
use Getopt::Long;

### DEFAULT SETTINGS

my $file;
my $nozoom    = 1;
my $maxbin    = 1000000;
my $maxwidth  = 1200;
my $maxheight = 1200;
my $seqdir    = 'seq';
my $dotdir    = 'dot';


# Enter path to geparcmd.sh
my $gepardcmd = 'gepardcmd.sh';

#Enter path to edna.mat
my $mat = '/home/UNIXHOME/jkaralius/src/gepard-1.30/matrices/edna.mat';



GetOptions(

	'file|in|i|fasta|fastq=s' => \$file,
	'nozoom'                   => \$nozoom,
	'maxbin'                   => \$maxbin,
	'maxwidth'                 => \$maxwidth,
	'maxheight' => \$maxheight,
	'seqdir=s' => \$seqdir,
	'dotdir=s' => \$dotdir,
	'geaprdcmd=s' => \$gepardcmd,
	'mat|matrix=s' => \$mat	


) || die $!;











my $in = Bio::SeqIO->new(-file => $file);

mkdir $dotdir;
mkdir $seqdir;

while (my $seq = $in->next_seq()){
    
    my $seqid = $seq->id;
    $seqid =~ s/\W+/_/g;
    my $seqlen = $seq->length;
    print STDERR $seqlen, "\n";

    my $outfile = "$seqid\.fa";
	my $outpath = $seqdir.'/'.$outfile;
    my $out = Bio::SeqIO->new(-file => ">$outpath" ,
	                  	      -format => 'FASTA');
        
    print STDERR $seq->id, "\t", $seq->length, "\t", $outfile, "\n";
    $out->write_seq($seq);

    
    my $seq1 = $outpath;
    my $seq2 = $outpath;
    my $zoom = int($seqlen/10000);
    if ($zoom < 30){
        $zoom = 30;
    }
    my $word   = 10;
    my $window = 0;

    
    my $pngpath = './'.$dotdir.'/'.$outfile.'.png';
    	
    #my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -maxwidth $maxwidth -maxheight $maxheight -word $word -window $window -outfile $pngpath";
	my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -zoom $zoom -word $word -window $window -outfile $pngpath";
	#my $cmd = "$gepardcmd -seq1 $seq1 -seq2 $seq2 -matrix $mat -word $word -window $window -outfile $pngpath";
    print STDERR $cmd, "\n";
    `$cmd`;
    
}
