package Handy;

use strict; 
use warnings;

use Log::Log4perl qw(:easy :no_extra_logdie_message);
use File::Which qw(which where);


=head1 NAME

Handy - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Handy;

=head1 DESCRIPTION

  Collection of handy methods etc..

=cut

my $L = Log::Log4perl::get_logger();

use Exporter qw(import);
our @EXPORT_OK = (qw(require_exe));

=head2 require_exe

Require external executable, also checks PATH. Returns executable.

=cut

sub require_exe{
    my ($exe) = @_;
    my $fexe = $exe;
    unless ((-e $fexe && -x _) || (($fexe = which($exe)) && -e $fexe && -x _ )){
        $L->info("  $exe .. failed");
        die "$exe not found/executable\n";
    }
    $L->info("  $exe .. ok");
    return $exe;
}

=head2 fh_is

=cut

sub fh_is{
    my ($fh) = @_;
    die "filehandle required" unless defined $fh;

    print $fh," ",ref $fh,"\n";
    
    if(-f $fh){
        return 0;
    }elsif(-p $fh or  -t $fh){
        return 1;
    }elsif(ref $fh eq 'SCALAR'){
        return 2;
    }else{
        die sprintf("%s: %s",(caller 0)[3],"Unknown filehandle type");
    }
}


=head1 AUTHOR

Thomas Hackl, E<lt>thackl@lim4.deE<gt>

=cut

1;

