package Ilbot::Date;
use strict;
use warnings;
use 5.010;
use Ilbot::Config qw/config/;

use Exporter qw/import/;

our @EXPORT_OK = qw/today mytime/;

BEGIN {
    if ($^V ge v5.016) {
        *mytime = config(backend => 'timezone') eq 'local'
                ? \&CORE::localtime : \&CORE::gmtime;
    }
    else {
        *mytime = config(backend => 'timezone') eq 'local'
                ? sub { localtime ($_[0] // time) }
                : sub { gmtime    ($_[0] // time) }
    }
}

# returns current date in gmt or local timezone in the form YYYY-MM-DD
sub today {
    my @d = mytime();
    return sprintf("%04d-%02d-%02d", $d[5]+1900, $d[4] + 1, $d[3]);
}


1;
