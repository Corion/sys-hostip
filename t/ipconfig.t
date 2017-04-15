use strict;
use warnings;

use Test::More tests => 2 * 10;

use File::Spec;
use Sys::HostIP;
use Sys::HostIP::MockUtils qw/mock_win32_hostip/;

sub mock_and_test {
    my ( $file, $expected_results, $test_name ) = @_;

    my $hostip = mock_win32_hostip($file);

    isa_ok( $hostip, 'Sys::HostIP' );

    is_deeply(
        $hostip->_get_win32_interface_info,
        $expected_results,
        $test_name,
    );

}

mock_and_test(
    'ipconfig-2k.txt',
    { 'Local Area Connection' => '169.254.109.232' },
    'Correct Win2K interface',
);

mock_and_test(
    'ipconfig-xp.txt',
    { 'Local Area Connection' => '0.0.0.0' },
    'Correct WinXP interface',
);

mock_and_test(
    'ipconfig-win7.txt',
    {
        'Local Area Connection'   => '192.168.0.10',
        'Local Area Connection 2' => '192.168.1.20',
    },
    'Correct Win7 interface',
);

mock_and_test(
    'ipconfig-win7-empty-name.txt',
    {
        '' => '192.168.1.101',
    },
    'Win7 interface, empty name',
    );

mock_and_test(
    'ipconfig-win10.txt',
    {
        'Ethernet' => '192.168.1.100',
    },
    'Correct Win10 interface',
    );

mock_and_test(
    'ipconfig-win2008-sv_SE.txt',
    {
        'Anslutning till lokalt n�tverk' => '192.168.40.241',
    },
    'Correct Windows Server 2008 interface in Swedish locale',
    );

mock_and_test(
    'ipconfig-win7-de_DE.txt',
    {
        'LAN-Verbindung' => '10.0.2.15',
    },
    'Correct Windows 7 interface in German locale',
    );

mock_and_test(
    'ipconfig-win7-fr_FR.txt',
    {
        'LAN-Verbindung' => '192.168.2.118',
        'VirtualBox Host-Only Network' => '192.168.56.1',
    },
    'Correct Windows 7 interface in French locale',
    );

mock_and_test(
    'ipconfig-win7-it_IT.txt',
    {
        'LAN-Verbindung' => '192.168.2.118',
        'VirtualBox Host-Only Network' => '192.168.56.1',
    },
    'Correct Windows 7 interface in Italian locale',
    );

mock_and_test(
    'ipconfig-win7-fi_FI.txt',
    {
        'LAN-Verbindung' => '192.168.2.118',
        'VirtualBox Host-Only Network' => '192.168.56.1',
    },
    'Correct Windows 7 interface in Finnish locale',
    );
