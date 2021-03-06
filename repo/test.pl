#!/usr/bin/env perl

# Author: Patrick Muff &lt;muff.pa@gmail.com&gt;
# Purpose: Compiles a Cydia repository

use Digest::MD5;

sub md5sum {   
    my $file = shift;
    my $digest = "";
    eval {
        open(FILE, $file) or die "Can't find file $file\n";
        my $ctx = Digest::MD5->new;
        $ctx->addfile(*FILE);
        $digest = $ctx->hexdigest;
        close(FILE);
    };
    if ($@) {
        print $@;
        return ""; 
    }  
    return $digest;
}

system("touch Packages && rm Packages");

# scan the packages and write output to file Packages 
system("dpkg-scanpackages --multiversion debs / > Packages");

# bzip2 it to a new file 
system("bzip2 -fks Packages");

# gzip it  
system("gzip -f Packages");

# scan again because we zipped the original file  
system("dpkg-scanpackages --multiversion debs / > Packages");

system("cp Release-Template Release");
# calculate the hashes and write to Release  
open(RLS, ">> Release");

print RLS $output;
close(RLS);

# remove Release.gpg  
system("rm Release.gpg");

# generate Release.gpg  
system("gpg -abs -o Release.gpg Release");

exit 0;
