BEGIN
 -- DBMS_NETWORK_ACL_ADMIN.DROP_ACL('all-network-PUBLIC.xml');
  DBMS_NETWORK_ACL_ADMIN.DROP_ACL('usgs_connections.xml');
  COMMIT;
end;

begin
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'usgs_connections.xml',
                                    description => 'USGS site connectivity',
                                    principal   => 'QUAKE',
                                    is_grant    => TRUE,
                                    privilege   => 'connect');
  COMMIT;
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'usgs_connections.xml',
                                    HOST => '*');
  COMMIT;
END;

/* Generate specific ACL for MSE_MON*/

begin
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'usgs_connections.xml',
                                       principal => 'QUAKE',
                                       is_grant  => TRUE,
                                       privilege => 'resolve');
  COMMIT;
	  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'usgs_connections.xml',
                                       principal => 'QUAKE',
                                       is_grant  => TRUE,
                                       privilege => 'connect');
  COMMIT;
end;

GRANT all ON UTL_HTTP TO QUAKE;

SELECT * FROM dba_network_acls;

SELECT * FROM dba_NETWORK_ACL_PRIVILEGES;

commit;
