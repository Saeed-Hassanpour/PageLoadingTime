prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>28940345540489837
,p_default_application_id=>104
,p_default_owner=>'LIDL_QC_P3'
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_kubicek_consulting_pageloadingtime
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(42609529958334157)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.KUBICEK-CONSULTING.PAGELOADINGTIME'
,p_display_name=>'Page Loading Time'
,p_category=>'INIT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'**  Author  : Saeed Hassanpour ',
'**  Company : Kubicek Consulting GmbH',
'**  Date    : 2020/08',
'**  Version : 1.0',
'*/',
'function render_loading(p_dynamic_action in apex_plugin.t_dynamic_action,',
'                        p_plugin         in apex_plugin.t_plugin)',
'    return apex_plugin.t_dynamic_action_render_result IS',
'',
'    p_item_name        CONSTANT p_dynamic_action.attribute_01%type:= p_dynamic_action.attribute_01;',
'',
'  ',
'    l_result           apex_plugin.t_dynamic_action_render_result;',
'    l_ajaxIdentifier   VARCHAR2(500) := apex_plugin.get_ajax_identifier;',
'  ',
'BEGIN',
'    -- Debug',
'    if apex_application.g_debug then',
'    apex_plugin_util.debug_dynamic_action(p_plugin         => p_plugin,',
'                                          p_dynamic_action => p_dynamic_action);',
'    end if;',
'',
'    -- Load JS',
'    apex_javascript.add_library(p_name           => ''apex-loading-time'',',
'                                p_directory      => p_plugin.file_prefix,',
'                                p_version        => NULL,',
'                                p_skip_extension => FALSE);                              ',
'  ',
'    -- Add JS Inline Code',
'    apex_javascript.add_onload_code (p_code => ''apexloadPage.getTime('' ||apex_javascript.add_value(p_item_name)||''',
'                                                                     '' ||apex_javascript.add_value(l_ajaxIdentifier)||'');'');',
'',
'    ',
'    l_result.javascript_function := ''function(){null}'';',
'',
'    return l_result;',
'  ',
'END render_loading;',
'',
'---',
'function ajax_render_loading (p_dynamic_action in apex_plugin.t_dynamic_action,',
'                              p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_ajax_result  IS',
'    ',
'    l_result        apex_plugin.t_dynamic_action_ajax_result;      ',
'    l_loadingTime   varchar2(100) default apex_application.g_x01;',
'  ',
'BEGIN',
'',
'    apex_debug.message(''Page Loading Time: '' ||  l_loadingTime);',
'    ',
'    --Insert into table and we will use for performance checking',
'    insert into QC_LOADTIME(  ',
'                                WORKSPACE_ID,',
'                                APPLICATION_ID,',
'                                PAGE_ID,',
'                                SESSION_ID,',
'                                ELAPSED_TIME,',
'                                CREATED_ON,',
'                                CREATED_BY)',
'                    values (',
'                                SYS_CONTEXT(''APEX$SESSION'', ''WORKSPACE_ID''),',
'                                :APP_ID,',
'                                :APP_PAGE_ID,',
'                                SYS_CONTEXT(''APEX$SESSION'', ''APP_SESSION''),',
'                                l_loadingTime,',
'                                sysdate,',
'                                :app_user); ',
'',
'    ',
'    ',
'    apex_json.open_object;',
'    apex_json.close_object;',
'    ',
'    return l_result;',
'',
'END ajax_render_loading;'))
,p_api_version=>2
,p_render_function=>'render_loading'
,p_ajax_function=>'ajax_render_loading'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This plugin holds the page loading time into table and we could use for the performance checking</p>',
'',
'<p>This is a sample query after firing this plugin in your pages</p>',
'<p>',
'SELECT application_id,',
'       page_id,',
'       TRUNC(AVG(elapsed_time),4) avg_elapsed_time',
'FROM qc_loadtime',
'WHERE 1=1',
'AND created_on BETWEEN TO_DATE(''202008120900'',''RRRRMMDDHH24MISS'') AND TO_DATE(''202008132300'',''RRRRMMDDHH24MISS'') ',
'--and to_char(CREATED_ON,''YYYYMMDD'') = ''20200813''',
'GROUP BY application_id,page_id',
'</p>'))
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/Saeed-Hassanpour/PageLoadingTime'
,p_files_version=>2
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(42610175798340102)
,p_plugin_id=>wwv_flow_api.id(42609529958334157)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Value Display'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>'<p>P3_LOADTIME</p>'
,p_help_text=>'<p>Name - enter or select page item in order to display value.</p>'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2866756E6374696F6E2829207B0D0A09766172206E6F772C20706167654C6F616454696D652C20616A61784964656E746966696572242C207468243B0D0A096C6574206469763B0D0A09766172207265717565737444617461203D207B7D3B0D0A090D0A';
wwv_flow_api.g_varchar2_table(2) := '0976617220617065786C6F616450616765203D207B0D0A090967657454696D653A2066756E6374696F6E28704974656D2C2070416A6178496429207B0D0A0909090D0A090909746824203D20746869733B0D0A0909090D0A0909092F2F68747470733A2F';
wwv_flow_api.g_varchar2_table(3) := '2F626C6F672E64616E69656C686F63686C6569746E65722E64652F323031382F30322F31312F6F7261636C652D617065782D706C7567696E2D706572666F726D616E63652F0D0A0909096E6F77203D206E6577204461746528292E67657454696D652829';
wwv_flow_api.g_varchar2_table(4) := '3B0D0A090909706167654C6F616454696D65203D20286E6F77202D20706572666F726D616E63652E74696D696E672E6E617669676174696F6E537461727429202F20313030303B0D0A0909092F2F2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D';
wwv_flow_api.g_varchar2_table(5) := '2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D0D0A09090909090D0A09090969662028704974656D290D0A09090909617065782E6974656D2820704974656D2029';
wwv_flow_api.g_varchar2_table(6) := '2E73657456616C75652820706167654C6F616454696D652020293B0D0A09090909090D0A0909092F2F0D0A09090972657175657374446174612E783031203D20706167654C6F616454696D653B0D0A0909090D0A0909092F2F43616C6C20617065782E73';
wwv_flow_api.g_varchar2_table(7) := '65727665722E706C7567696E0D0A0909097468242E616A617843616C6C2870416A61784964293B0D0A09090D0A09097D2C0D0A09090D0A0909616A617843616C6C203A2066756E6374696F6E2870416A6178496429207B0D0A0909090909617065782E73';
wwv_flow_api.g_varchar2_table(8) := '65727665722E706C7567696E2870416A617849642C207265717565737444617461293B0D0A0909090909617065782E64656275672E696E666F2827415045582050616765204C6F6164696E672054696D655B44454255472E494E464F5D3A2027202C2072';
wwv_flow_api.g_varchar2_table(9) := '657175657374446174612E783031293B0D0A0909207D0D0A097D09200D0A0977696E646F772E617065786C6F616450616765203D20617065786C6F6164506167653B0D0A7D2928617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(42609896153336054)
,p_plugin_id=>wwv_flow_api.id(42609529958334157)
,p_file_name=>'apex-loading-time.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
