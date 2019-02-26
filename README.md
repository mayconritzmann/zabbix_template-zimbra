# zabbix-zimbra-monitoring
Monitoring Zimbra services states with zabbix.

#### Files in repository:
1) Template Zimbra.xml - template for zimbra monitoring. Import on zabbix server.

2) userparameter_zimbra.conf - Config with UserParameter settings. Put it in the /etc/zabbix/zabbix_agentd.d/ directory (or something like this), then include in zabbix agent configuration file ("Include=/etc/zabbix/zabbix_agentd.d/").

4) zimbra_status.sh - monitoring script. Put in zabbix monitoing scripts directory (in my case its "/etc/zabbix/scripts")
