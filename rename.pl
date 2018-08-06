#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use IO::Uncompress::Unzip qw(unzip $UnzipError);
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );use File::Copy qw(move);
use IO::Compress::Zip qw(zip $ZipError) ;
use List::MoreUtils;use Time::Piece;
use Archive::Extract;

open my $fh, ">", 'logfile.txt' 
  or die "Can't open the log file: $!";
  
  my $from_address = 'transportal@topslab.wisc.edu';
my $smtp_host = 'smtp.wiscmail.wisc.edu';
my $recipients = 'cheng8@wisc.edu';
my $fromEmailState = join "","From e-mail address is: ", $from_address, "\n";
my $smtpHostState = join "", "smtp host e-mail is ", $smtp_host, "\n";
my $recipientsState = join "", "Recipients e-mail is ", $recipients, "\n";
print $fh $fromEmailState;
print $fh $smtpHostState;
print $fh $recipientsState;
# Path to the directory
my $path = "C:/Users/Owner/Desktop/Perl";

# Open and read content of the directory
#opendir(D, "$path") || die "Can't open directory $path: $!\n";
if (opendir(D, "$path")) {
    print $fh "Open directory $path: $!\n";
} else {
    print $fh "Can't open directory $path: $!\n"; }
# Define the number of the past days to iterate
my $numPast = 2;
my $index = 1;
while ($index < $numPast) {

    # The date of last day to start 
    my $now = time();
    my $threeDaysAgo = $now - $index * 86400;
    my ($day, $mon, $year) = (localtime($threeDaysAgo))[3, 4, 5];
    printf("One day ago was %04d-%02d-%02d", $year+1900, $mon+1, $day);
    print "\n";
    my $dateState = join "","One day ago was ", $year+1900, "-", $mon+1, "-", $day, ".";
    print $fh $dateState;
    print $fh "\n";
    

    # Check file
    my $prefix = "d2d";
    my $yearStr = $year+1900;
    my $monStr = join "", "0", $mon+1;
    my $dayStr = join "", $day;
    my $dateString = join "", $yearStr, $monStr, $dayStr;
    my $postfix = ".zip";
    my $lastDayFile = join "", $prefix, $dateString, $postfix;
    print "Last Day '$lastDayFile' to start!\n";
    my $fileName = join "","Last Day ", $lastDayFile, " to start!";
    print $fh $fileName;
    print $fh "\n";    
        # Error Check
    if (-e $lastDayFile) { # Check whether file exists
        print "The last day file exists\n";
        print $fh "The last day file exists!\n";
    } else {
            print "The last day file '$lastDayFile' does not exist!\n";
            my $failState = join "","The last day file ", $lastDayFile, " does not exist!\n";
            print $fh $failState;
            print "Download the file '$lastDayFile'! \n";
            my $downloadState = join "", "Download the file", $lastDayFile, "!\n";
            print $fh $downloadState;
    }
        
    my $zip = Archive::Zip->new($lastDayFile);
    my $extractState = "Starting to extract!\n";
    print $fh $extractState;
    foreach my $member ($zip->members)
    {
     
        next if $member->isDirectory;
        (my $extractName = $member->fileName) =~ s{.*/}{};
        $member->extractToFileNamed(
        "$path/$extractName");
    }
    
        # Rename
    my $renameState = "Starting to rename!\n";
    print $fh $renameState;
    my $oldFile1 = join "", $prefix, $dateString, ".csv"; 
    my $oldFile2 = join "", $prefix, $dateString, "Controllers.csv";
    my $oldFile3 = join "", $prefix, $dateString, "Detectors.csv";
    my $newFile1 = "d2d_detlog.csv";
    my $newFile2 = "d2d_Controllers.csv";
    my $newFile3 = "d2d_Detectors.csv";
    move $oldFile1, $newFile1;
    move $oldFile2, $newFile2;
    move $oldFile3, $newFile3;
    
        # Delete Files
    my $deleteState = "Starting to delete!\n";
    print $fh $deleteState;
    unlink $newFile1;
    if(-e $newFile1) 
    {
        print "'$newFile1' file still exists!";
        my $newFileState1 = join "", $newFile1, " file stll exists!\n";
        print $fh $newFileState1;
    }
    else 
    {
        print "'$newFile1' file gone.";
        my $newFileGone1 = join "", $newFile1, " file gone!\n";
        print $fh $newFileGone1;
    }

    unlink $newFile2;
    if(-e $newFile2) 
    {
        print "'$newFile2' file still exists!";
        my $newFileState2 = join "", $newFile2, " file stll exists!\n";
        print $fh $newFileState2;
    }
    else 
    {
        print "'$newFile2' file gone.";
        my $newFileGone2 = join "", $newFile2, " file gone!\n";
        print $fh $newFileGone2;
    }

    unlink $newFile3;
    if(-e $newFile3) 
    {
        print "'$newFile3' file still exists!";
        my $newFileState3 = join "", $newFile3, " file stll exists!\n";
        print $fh $newFileState3;
    }
    else 
    {
        print "'$newFile3' file gone.";
        my $newFileGone3 = join "", $newFile3, " file gone!\n";
        print $fh $newFileGone3;
    }

    
    $index += 1;
    my $dayIndex = join "", "Iteration of day Index is ",$index,".\n";
    print $fh $dayIndex;}








