#!/usr/bin/perl
#
# Convert the runscript from parallels guest tools
#

my $section_name;
my $section_header = 0;

while(<>)
{
	if(!(/^#/)) 
	{
		$section_header = 0;
	}
	if( /^###/ )
	{
		$section_name = "" if( !$section_header );
		if( /^### BEGIN (.+)$/ )
		{
			$section_name = $1;
			$section_header = 1;
		}
		elsif( !$section_name )
		{
			$section_header = "pending";
		}
	}
	elsif( $section_header eq "pending" )
	{
		m/^# (.+)/;
		$section_name = $1;
		$section_header = 1;
	}
	if( ($section_name =~ /^chkconfig/) || (/^PATH=/) || ($section_name =~ m!^Start/stop guest tools!) )
	{
		# Filter these things out
		next;
	}
	if( m-^#!/bin/sh- )
	{
		print "#!/sbin/openrc-run\n";
		next;
	}
	#print "#section_name='$section_name', section_header='$section_header'\n";
	print;
}
