#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Time::HiRes qw(usleep nanosleep);
​
while(1){
    my $db_host = '127.0.0.1';
    my $db_port = '3306';
    my $db_user = 'root';
    my $db_pass = '';
    my $db_name = 'test_perl';
    ​
    my $dsn = "DBI:mysql:database=$db_name;host=$db_host;port=$db_port";
    my $dbh = DBI->connect($dsn, $db_user, $db_pass);
    $dbh->{mysql_auto_reconnect} = 1;
    $dbh->do("set character set utf8");
    ​
    my $search_sql = "SELECT * FROM test";
    my $search_result = $dbh->prepare($search_sql);
    $search_result->execute;
    my $search_result_rows = $search_result->rows();
    if ($search_result_rows > 1) {
        while (my @row = $search_result->fetchrow_array()) {
            my ($id, $name, $describe ) = @row;
                print("Test:$id, $name, $describe\n");
        }
    }
}