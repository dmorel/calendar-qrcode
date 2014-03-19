#!/usr/bin/env perl

use strict;
use warnings;

use Data::ICal;
use Date::ICal;
use Data::ICal::Entry::Event;
use Date::Parse 'str2time';
use Imager::QRCode 'plot_qrcode';
use Data::Dumper;

my $calendar = Data::ICal->new();
my $vevent   = Data::ICal::Entry::Event->new();
$vevent->add_properties(
    summary     => "Cécile's first event",
    description => "My very first event in QRCode <http://calvinhobbesdaily.tumblr.com/>",
    location    => "Place de la Croix-Rousse, Lyon, France",
    dtstart     => Date::ICal->new( epoch => str2time("2014-03-20 20:30:00") )->ical,
    dtend       => Date::ICal->new( epoch => str2time("2014-03-20 22:00:00") )->ical,
    url         => "http://calvinhobbesdaily.tumblr.com/",
);
$calendar->add_entry($vevent);

#$vevent->add_entry($alarm);
my $out = $calendar->as_string;
$out =~ s/^.+?BEGIN:VEVENT/BEGIN:VEVENT/gmxs;
$out =~ s/END:VEVENT.+$/END:VEVENT/gmxs;
my $img = plot_qrcode( $out, () );
$img->write( file => "/tmp/qrcode.gif", type => 'gif' )
    or die "Cannot write qrcode", $img->errstr;
