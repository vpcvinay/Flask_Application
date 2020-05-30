create table "ugw_sitesinfo" (
	"siteid" serial not null,
	"sitename" varchar(50) not null,
	"sitedetails" json,
	constraint ugw_sites_pk primary key ("siteid")
);

create table "ugw_rangeidtypes" (
	"rangetypeid" serial not null,
	"rangeidtypename" varchar(50) not null,
	"rangeidtypedetails" json,
	constraint ugw_rangeidtypes_pk primary key ("rangetypeid")
);

create table "ugw_radiosystemtypes" (
	"radiotypeid" serial not null,
	"radiosystemtype" varchar(50) not null unique,
	"radiotypedetails" json,
	constraint ugw_radiosystemtypes_pk primary key ("radiotypeid")
);

create table "ugw_rangesinfo" ( 
    "rangeid" serial not null, 
    "radiotypeid" integer not null,
    "rangetypeid" integer not null, 
    "rangestartid" varchar(50) not null,
    "range" integer not null default '1', 
    "rangedetails" json,
    constraint ugw_ranges_pk primary key ("rangeid")
);
alter table "ugw_rangesinfo" add constraint "ugw_rangesinfo_fk0" foreign key ("rangetypeid") references "ugw_rangeidtypes"("rangetypeid");
alter table "ugw_rangesinfo" add constraint "ugw_rangesinfo_fk1" foreign key ("radiotypeid") references "ugw_radiosystemtypes"("radiotypeid");

create table "ugw_servicesinfo" ( 
    "serviceid" serial not null, 	
    "servicename" varchar(500) not null,
    "accessprofileid" integer, 
    "servicedetails" json, 
    constraint ugw_services_pk primary key ("serviceid")
);
alter table "ugw_servicesinfo" add constraint "ugw_servicesinfo_fk0" foreign key ("accessprofileid") references "ugw_accessprofiles"("accessprofileid");

create table "ugw_serviceinstancesinfo" ( 
    "serviceinstanceid" serial not null,
    "serviceid" integer not null, 
    "serviceinstancename" varchar(500) not null,
    "accessprofileid" integer not null,
    "resrcaccessgroupid" integer, 
    "prefferedidtype" integer,
    "serviceinstancedetails" json,
    constraint ugw_serviceinstance_pk primary key ("serviceinstanceid","serviceid")
);
alter table "ugw_serviceinstancesinfo" add constraint "ugw_serviceinstancesinfo_fk0" foreign key ("serviceid") references "ugw_servicesinfo"("serviceid");
alter table "ugw_serviceinstancesinfo" add constraint "ugw_serviceinstancesinfo_fk1" foreign key ("accessprofileid") references "ugw_accessprofiles"("accessprofileid");

create table "ugw_wrgdetailsinfo" ( 
    "wrgid" bigint not null,
    "wrgname" varchar(50),
    "radiotypeid" integer not null, 
    "wrgdetails" json,
    constraint ugw_radiosystemdetails_pk primary key ("wrgid")
);
alter table "ugw_wrgdetailsinfo" add constraint "ugw_wrgdetailsinfo_fk0" foreign key ("radiotypeid") references "ugw_radiosystemtypes"("radiotypeid");


create table "ugw_systeminfo" ( 
    "systemid" serial not null, 
    "systemname" varchar(200) not null unique,
    "broadbandsysid" integer,
    "systemdesc" varchar(4000), 
    "radiotypeid" integer not null,
    "systeminfodetails" json, 
    constraint ugw_systeminfo_pk primary key ("systemid")
);
alter table "ugw_systeminfo" add constraint "ugw_systeminfo_fk0" foreign key ("radiotypeid") references "ugw_radiosystemtypes"("radiotypeid");

create table "ugw_systemsitesmapping" (
    "systemid" integer not null, 
    "siteid" integer not null,
    "systemsitesdetails" json, 
    constraint ugw_systemsitesmapping_pk primary key ("systemid","siteid")
);
alter table "ugw_systemsitesmapping" add constraint "ugw_systemsitesmapping_fk0" foreign key ("systemid") references "ugw_systeminfo"("systemid");
alter table "ugw_systemsitesmapping" add constraint "ugw_systemsitesmapping_fk1" foreign key ("siteid") references "ugw_sitesinfo"("siteid");


create table "ugw_systemrangemapping" ( 
    "systemid" integer not null,
    "rangeid" integer not null, 
    "radiosystemtype" varchar(50), 
    "rangeidtypename" varchar(50),	
    "systemrangedetails" json, 
    constraint ugw_systemrangemapping_pk primary key ("systemid","rangeid")
);
alter table "ugw_systemrangemapping" add constraint "ugw_systemrangemapping_fk0" foreign key ("systemid") references "ugw_systeminfo"("systemid");
alter table "ugw_systemrangemapping" add constraint "ugw_systemrangemapping_fk1" foreign key ("rangeid") references "ugw_rangesinfo"("rangeid");


create table "ugw_wrgrangemapping" ( 
    "wrgid" bigint not null,
    "rangeid" integer not null, 
    "rangeidtypename" varchar(50) not null,
    "wrgrangedetails" json, 
    constraint ugw_wrgrangemapping_pk primary key ("wrgid","rangeid")
);
alter table "ugw_wrgrangemapping" add constraint "ugw_wrgrangemapping_fk0" foreign key ("wrgid") references "ugw_wrgdetailsinfo"("wrgid");
alter table "ugw_wrgrangemapping" add constraint "ugw_wrgrangemapping_fk1" foreign key ("rangeid") references "ugw_rangesinfo"("rangeid");


create table "ugw_systemwrgmapping" ( 
    "systemid" integer not null, 
    "wrgid" bigint not null,
    "systemwrgdetails" json, 
    constraint ugw_systemwrgmapping_pk primary key ("systemid","wrgid")
);
alter table "ugw_systemwrgmapping" add constraint "ugw_systemwrgmapping_fk0" foreign key ("systemid") references "ugw_systeminfo"("systemid");
alter table "ugw_systemwrgmapping" add constraint "ugw_systemwrgmapping_fk1" foreign key ("wrgid") references "ugw_wrgdetailsinfo"("wrgid");


create table "ugw_accountinfo" ( 
    "accountid" serial not null,
    "accountname" varchar(500) not null, 
    "accountdomainname" varchar(500) unique,
    "resrcaccessgroupid" integer not null,
    "accountdetails" json, 
    constraint ugw_accountinfo_pk primary key ("accountid")
);
alter table "ugw_accountinfo" add constraint "ugw_accountinfo_fk0" foreign key ("resrcaccessgroupid") references "ugw_resourceaccessgroupsinfo"("resrcaccessgroupid");


create table "ugw_accountsitesmapping" ( 
    "accountid" integer not null,
    "siteid" integer not null, 
    "accounttositesmappingdetails" json,
    constraint ugw_accountsitesmapping_pk primary key ("accountid","siteid")
);
alter table "ugw_accountsitesmapping" add constraint "ugw_accountsitesmapping_fk0" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_accountsitesmapping" add constraint "ugw_accountsitesmapping_fk1" foreign key ("siteid") references "ugw_sitesinfo"("siteid");


create table "ugw_accountsystemmapping" ( 
    "accountid" integer not null,
    "systemid" integer not null, 
    "accountsystemdetails" json,
    constraint ugw_accountsystemmapping_pk primary key ("accountid","systemid")
);
alter table "ugw_accountsystemmapping" add constraint "ugw_accountsystemmapping_fk0" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_accountsystemmapping" add constraint "ugw_accountsystemmapping_fk1" foreign key ("systemid") references "ugw_systeminfo"("systemid");

create table "ugw_accountsystemrangemapping" ( 	
    "accountid" integer not null,
    "systemid" integer not null, 
    "rangeid" integer not null, 
    "accountsystemrangedetails" json,
     constraint ugw_accountsystemrangemapping_pk primary key ( "accountid", "systemid", "rangeid")
);
alter table "ugw_accountsystemrangemapping" add constraint "ugw_accountsystemrangemapping_fk0" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_accountsystemrangemapping" add constraint "ugw_accountsystemrangemapping_fk1" foreign key ("systemid") references "ugw_systeminfo"("systemid");
alter table "ugw_accountsystemrangemapping" add constraint "ugw_accountsystemrangemapping_fk3" foreign key ("rangeid") references "ugw_rangesinfo"("rangeid");


create table "ugw_accountsrvinstancemapping" ( 
    "accountid" integer not null,
    "serviceid" integer not null, 
    "serviceinstanceid" integer not null,
    "preferredsystemforidformat" integer, 
    "accessprofileid"  integer not null,
    "accountserviceinstancedetails" json,
    constraint ugw_accountsrvinstancemapping_pk primary key ( "accountid", "serviceid", "serviceinstanceid") );
alter table "ugw_accountsrvinstancemapping" add constraint "ugw_accountsrvinstancemapping_fk0" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_accountsrvinstancemapping" add constraint "ugw_accountsrvinstancemapping_fk1" foreign key ("serviceid","serviceinstanceid") references "ugw_serviceinstancesinfo"("serviceid","serviceinstanceid");
alter table "ugw_accountsrvinstancemapping" add constraint "ugw_accountsrvinstancemapping_fk2" foreign key ("accessprofileid") references "ugw_accessprofiles"("accessprofileid");


create table "ugw_userrolestype" (
    "userroleid" serial not null,
    "userrolename" varchar(500) not null unique,
    "userroledetails" json,
    constraint ugw_userrolestype_pk primary key ("userroleid")
);


create table "ugw_usersinfo" (
    "userid" serial not null,
    "username" varchar(200) not null unique,
    "useremail" varchar(200) not null unique,
    "userpassword" text not null,
    "userroleid" integer not null,
    "userdetails" json,
    constraint ugw_usersinfo_pk primary key ("userid")
);
alter table "ugw_usersinfo" add constraint "ugw_users_fk0" foreign key ("userroleid") references "ugw_userrolestype"("userroleid");


create table "ugw_accountusermapping" ( 
    "accountid" integer not null,
    "userid" integer not null, 
    "accountuserdetails" json,
    constraint ugw_accountusermapping_pk primary key ("accountid","userid")
);
alter table "ugw_accountusermapping" add constraint "ugw_accountusermapping_fk0" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_accountusermapping" add constraint "ugw_accountusermapping_fk1" foreign key ("userid") references "ugw_usersinfo"("userid");

create table "ugw_resourcetype" ( 
    "resourceidtype" serial not null,
    "resourceidtypeinfo" varchar(50) not null,  
    "resourceidtypedetails" json,
    constraint ugw_resourcetype_pk primary key ("resourceidtype")
);

create table "ugw_resourceinfo" (
    "resourceseqid" serial not null,
    "systemid" integer null, 
    "radiotypeid" integer null,
    "resourceidtype" integer not null, 
    "resourceid" varchar(50) unique,
    "resourcename" varchar(50) not null,
    "resourcetype" varchar(50) not null, 
    "ugwresourceid" varchar(50) not null,
    "resourceprofileid" varchar(50) not null,
    "resourcedetails" json, 
    constraint ugw_resourceinfo_pk primary key ("resourceseqid")
);
alter table "ugw_resourceinfo" add constraint "ugw_resourceinfo_fk0" foreign key ("systemid") references "ugw_systeminfo"("systemid");
alter table "ugw_resourceinfo" add constraint "ugw_resourceinfo_fk1" foreign key ("resourceidtype") references "ugw_resourcetype"("resourceidtype");
alter table "ugw_resourceinfo" add constraint "ugw_resourceinfo_fk2" foreign key ("radiotypeid") references "ugw_radiosystemtypes"("radiotypeid");

create table "ugw_pseudoresourceinfo" (
    "pseudoresourceseqid" serial not null,
    "ugwpresourceid" varchar(50) not null,
    "remoteresourceid" varchar(50) not null,
    "remoteresourceidtype" integer not null,
    "remotesystemid" integer not null,
    "pseudoresrcdetails" json,
    constraint ugw_pseudoresourceinfo_pk primary key ("pseudoresourceseqid")
);
alter table "ugw_pseudoresourceinfo" add constraint "ugw_pseudoresourceinfo_fk0" foreign key ("remoteresourceid") references "ugw_resourceinfo"("resourceid");
alter table "ugw_pseudoresourceinfo" add constraint "ugw_pseudoresourceinfo_fk1" foreign key ("remoteresourceidtype") references "ugw_resourcetype"("resourceidtype");
alter table "ugw_pseudoresourceinfo" add constraint "ugw_pseudoresourceinfo_fk2" foreign key ("remotesystemid") references "ugw_systeminfo"("systemid");

create table "ugw_resourceprofile" (
    "profileid" serial not null,
    "profilename" varchar(50) not null,
    "profilefeatureset" json,
    "resourceidtype" integer not null,
    "radiotypeid" integer not null,
    "Isdefault" integer not null,
    "ownertype" integer not null,
    "owner" integer not null,
    "deviceprofiledetails" json,
    constraint ugw_resourceprofile_pk primary key ("profileid")
);
alter table "ugw_resourceprofile" add constraint "ugw_resourceprofile_fk1" foreign key ("resourceidtype") references "ugw_resourcetype"("resourceidtype");
alter table "ugw_resourceprofile" add constraint "ugw_resourceprofile_fk2" foreign key ("radiotypeid") references "ugw_radiosystemtypes"("radiotypeid");

create table "ugw_resourcelist" (
    "resourcelistid" serial not null,
    "resourcelistname" varchar(50),
    "resources" varchar(50) not null,
    "resrclevel" integer not null,
    "ownertype" integer not null,
    "owner" integer not null,
    "resourcelistdetails" json,
    constraint ugw_resourcelist_pk primary key ("resourcelistid", "resources")
);
alter table "ugw_resourcelist" add constraint "ugw_resourcelist_fk0" foreign key ("resources") references "ugw_resourceinfo"("resourceid");

create table "ugw_resourceaccessgroupsinfo" (
    "resrcaccessgroupid" serial not null,
    "resrcaccessgroupname" varchar(50),
    "resrcaccgrplevel" integer not null,
    "resrcaccessgroupparent" integer,
    "ownertype" integer not null,
    "owner" integer not null,
    "resrcaccgrpsdetails" json,
    constraint ugw_resourceaccessgroupsinfo_pk primary key ("resrcaccessgroupid")
);

create table "ugw_rag_resourcemapping" (
    "resrcaccessgroupid" integer not null,
    "resource" varchar(50),
    "rag_resourcemappingdetails" json,
    constraint ugw_rag_resourcemapping_pk primary key ("resrcaccessgroupid", "resource")
);

alter table "ugw_rag_resourcemapping" add constraint "ugw_rag_resourcemapping_fk1" foreign key ("resrcaccessgroupid") references "ugw_resourceaccessgroupsinfo"("resrcaccessgroupid");
alter table "ugw_resourceaccessgroupsinfo" add constraint "ugw_resourceaccessgroupsinfo_fk2" foreign key ("resource") references "ugw_resourceinfo"("resourceid");

create table "ugw_rag_accountmapping" (
    "resrcaccessgroupid" integer not null,
    "accountid" integer not null,
    "accessprofileid" integer not null,
    "ownertype" integer not null,
    "owner" integer not null,
    "isEditable" integer,
    "rag_accountmappingdetails" json,
    constraint ugw_rag_accountmapping_pk primary key ("resrcaccessgroupid", "accountid", "accessprofileid"));

alter table "ugw_rag_accountmapping" add constraint "ugw_rag_accountmapping_fk1" foreign key ("resrcaccessgroupid") references "ugw_resourceaccessgroupsinfo"("resrcaccessgroupid");
alter table "ugw_rag_accountmapping" add constraint "ugw_rag_accountmapping_fk2" foreign key ("accountid") references "ugw_accountinfo"("accountid");
alter table "ugw_rag_accountmapping" add constraint "ugw_rag_accountmapping_fk3" foreign key ("accessprofileid") references "ugw_accessprofiles"("accessprofileid");

create table "ugw_rag_srvinstancemapping" (
    "resrcaccessgroupid" integer not null,
    "serviceinstanceid" integer not null,
    "accessprofileid" integer not null,
    "accountid" integer not null,
    "rag_srvinsmappingdetails" json,
    constraint ugw_rag_srvinstancemapping_pk primary key ("resrcaccessgroupid", "serviceinstanceid",  "accessprofileid"));
alter table "ugw_rag_srvinstancemapping" add constraint "ugw_rag_srvinstancemapping_fk0" foreign key ("resrcaccessgroupid") references "ugw_resourceaccessgroupsinfo"("resrcaccessgroupid");
alter table "ugw_rag_accountmapping" add constraint "ugw_rag_accountmapping_fk1" foreign key ("accessprofileid") references "ugw_accessprofiles"("accessprofileid");
alter table "ugw_rag_accountmapping" add constraint "ugw_rag_accountmapping_fk2" foreign key ("accountid") references "ugw_accountinfo"("accountid");

create table "ugw_accessprofiles" (
"accessprofileid" serial not null,
"allowedfeatureset" json , 
"ownertype" integer not null,
"owner" integer not null,
"accessprofiledetails" json,
constraint ugw_accessprofiles_pk primary key ("accessprofileid"));

create table "ugw_imwinfo" (
"imwsysid" varchar(50) not null,
"imwsystemname" json , 
"authserverfqdn" varchar(50) not null,
"authserverport" integer not null,
"locationserverfqdn" varchar(50) not null,
"locationserverport" integer not null,
"presenceserverfqdn" varchar(50) not null,
"presenceserverport" integer not null,
"imwsystemdetails" json,
constraint ugw_imwinfo_pk primary key ("imwsysid")
);

create table "ugw_imwwrgmapping" (
   "imwsysid" varchar(50) not null,
   "systemid" integer not null, 
   "imw_wrgdetails" json,
   constraint ugw_imwwrgmapping_pk primary key ("imwsysid", "systemid")
);

alter table "ugw_imwwrgmapping" add constraint "ugw_imwwrgmapping_fk0" foreign key ("imwsysid") references "ugw_imwinfo"("imwsysid");
alter table "ugw_imwwrgmapping" add constraint "ugw_imwwrgmapping_fk1" foreign key ("systemid") references "ugw_systeminfo"("systemid");

create table "ugw_imwaccountmapping" (
   "imwsysid" varchar(50) not null,
   "accountid" integer not null,
   "Imwagency" varchar(50), 
   "imw_ugwaccountmapdetails" json,
   constraint ugw_imwaccountmapping_pk primary key ("imwsysid", "accountid")
);
alter table "ugw_imwaccountmapping" add constraint "ugw_imwaccountmapping_fk0" foreign key ("imwsysid") references "ugw_imwinfo"("imwsysid");
alter table "ugw_imwaccountmapping" add constraint "ugw_imwaccountmapping_fk1" foreign key ("accountid") references "ugw_accountinfo"("accountid");
