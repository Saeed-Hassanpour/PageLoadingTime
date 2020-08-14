# PageLoadingTime
**A Dynamic Action Plugin for Oracle Application Express**

**This plugin holds the page loading time into table and we could use for the performance checking**


![](https://raw.githubusercontent.com/Saeed-Hassanpour/PageLoadingTime/master/preview.gif)

## DEMO ##

[https://apex.oracle.com/pls/apex/f?p=OAC:15](https://apex.oracle.com/pls/apex/f?p=OAC:15)


## PRE-REQUISITES ##

* [Oracle Application Express 5.1 and later](https://apex.oracle.com)

## INSTALLATION ##

1. Download the **[latest release](https://github.com/Saeed-Hassanpour/PageLoadingTime/releases/latest)**
2. Import plugin **dynamic_action_plugin_de_kubicek-consulting_pageloadingtime.sql** to your APEX APPs
3. Add to pages only with two clicks
4. Create a Table for holding times

<pre>
CREATE SEQUENCE  "QC_LOADTIME_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
 /
  CREATE TABLE "QC_LOADTIME" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"WORKSPACE_ID" NUMBER, 
	"APPLICATION_ID" NUMBER, 
	"PAGE_ID" NUMBER, 
	"SESSION_ID" NUMBER, 
	"ELAPSED_TIME" NUMBER, 
	"CREATED_ON" TIMESTAMP (6), 
	"CREATED_BY" VARCHAR2(100 BYTE), 
	 CONSTRAINT "QC_LOADTIME_PK" PRIMARY KEY ("ID")
 )
/

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_QC_LOADTIME" 
  before insert on "QC_LOADTIME"               
  for each row  
begin   
  if :NEW."ID" is null then 
    select "QC_LOADTIME_SEQ".nextval into :NEW."ID" from sys.dual; 
  end if; 
end; 
/
ALTER TRIGGER "BI_QC_LOADTIME" ENABLE;
</pre>


5. check the performance by this query

<pre>
SELECT application_id,
       page_id,
       TRUNC(AVG(elapsed_time),4) avg_elapsed_time
FROM   qc_loadtime
WHERE  1=1
AND    created_on BETWEEN TO_DATE('202008120900','RRRRMMDDHH24MISS') AND TO_DATE('202008132300','RRRRMMDDHH24MISS') 
--and  to_char(CREATED_ON,'YYYYMMDD') = '20200813'
GROUP BY application_id,page_id
/
</pre>

