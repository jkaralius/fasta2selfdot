#FASTA2SELFDOT#

fasta2selfdot.pl

##TITLE##

fasta2selfdot

##DESCRIPTION##

Script takes a multi-FASTA or FASTQ file input and breaks it up into single sequence files, then runs self-by-self dot plots with
Gepard <http://http://www.helmholtz-muenchen.de/icb/software/gepard/index.html>

Outputs all single-sequence FASTA files into directory "./seq", and dot plots go into "./dot".


##PREREQUISITES##

* Gepard (http://www.helmholtz-muenchen.de/icb/software/gepard/index.html)
* Bioperl (http://www.biperl.org)


##USAGE##

```fasta2selfdot.pl -i /path/to/sequence.fasta```


###Options###

    -i : /path/to/input/seqfile

##AUTHOR##

Joey Karalius https://github.com/jkaralius

##ISSUES##

https://github.com/jkaralius/fasta2selfdot/issues

