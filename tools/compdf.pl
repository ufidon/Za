#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
 
use File::Find::Rule;
use File::Basename qw(basename);


# Usage: compdf.pl <folder> <combined pdf file name>

my $path = $ARGV[0];
my $respdf = $ARGV[1];

my $bookmarkfile = 'data.txt';


open(my $out, '>', $bookmarkfile) or die "Could not open '$bookmarkfile' $!\n";
 
my @full_pathes = File::Find::Rule->file->name(qr/\.[pP][dD][fF]$/)->in($path);
my @rfp = reverse sort @full_pathes;
my @files = map { lc basename $_ } @full_pathes;

my @pdffiles = ();
my $bookmarks = "";

my $tmpstr = "";
my $fname = "";
my $pageno = 1;
my $pages = 0;
my $bks = "";
my $bk = "";

# ```
# BookmarkBegin
# BookmarkTitle: Chapter 12: Digital Signature Schemes
# BookmarkLevel: 1
# BookmarkPageNumber: 460
# ```

for my $fp (@rfp)
{
    # 构建文件列表
    push(@pdffiles, $fp);

    # 构建书签
    $tmpstr = `pdftk $fp dump_data | grep -i NumberOfPages`;
    $pages = int((split(/:/,$tmpstr))[1]);

    $fname = substr($fp, 0, -4);
    $bk = "BookmarkBegin\n" . "BookmarkTitle: " . $fname . "\n" . "BookmarkLevel: 1\n" . "BookmarkPageNumber: " . $pageno . "\n";
    $pageno += $pages;
    $bks .= $bk;
    #print($fname,"\n");
}

print($bks);

print $out $bks;
close($out);

my $pdffilesstr = join(" ", @pdffiles);
my $rescon = `pdftk $pdffilesstr cat output tmp.pdf`;

# 更新书签
$rescon = `pdftk tmp.pdf update_info data.txt output $respdf`;