/*
**  Author  : Saeed Hassanpour 
**  Company : Kubicek Consulting GmbH
**  Date    : 2020/08
**  Version : 1.0
*/
function render_loading(p_dynamic_action in apex_plugin.t_dynamic_action,
                        p_plugin         in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result IS

    p_item_name        CONSTANT p_dynamic_action.attribute_01%type:= p_dynamic_action.attribute_01;

  
    l_result           apex_plugin.t_dynamic_action_render_result;
    l_ajaxIdentifier   VARCHAR2(500) := apex_plugin.get_ajax_identifier;
  
BEGIN
    -- Debug
    if apex_application.g_debug then
    apex_plugin_util.debug_dynamic_action(p_plugin         => p_plugin,
                                          p_dynamic_action => p_dynamic_action);
    end if;

    -- Load JS
    apex_javascript.add_library(p_name           => 'apex-loading-time',
                                p_directory      => p_plugin.file_prefix,
                                p_version        => NULL,
                                p_skip_extension => FALSE);                              
  
    -- Add JS Inline Code
    apex_javascript.add_onload_code (p_code => 'apexloadPage.getTime(' ||apex_javascript.add_value(p_item_name)||'
                                                                     ' ||apex_javascript.add_value(l_ajaxIdentifier)||');');

    
    l_result.javascript_function := 'function(){null}';

    return l_result;
  
END render_loading;

---
function ajax_render_loading (p_dynamic_action in apex_plugin.t_dynamic_action,
                              p_plugin         in apex_plugin.t_plugin )
    return apex_plugin.t_dynamic_action_ajax_result  IS
    
    l_result        apex_plugin.t_dynamic_action_ajax_result;      
    l_loadingTime   varchar2(100) default apex_application.g_x01;
  
BEGIN

    apex_debug.message('Page Loading Time: ' ||  l_loadingTime);
    
    --Insert into table and we will use for performance checking
    insert into QC_LOADTIME(  
                                WORKSPACE_ID,
                                APPLICATION_ID,
                                PAGE_ID,
                                SESSION_ID,
                                ELAPSED_TIME,
                                CREATED_ON,
                                CREATED_BY)
                    values (
                                SYS_CONTEXT('APEX$SESSION', 'WORKSPACE_ID'),
                                :APP_ID,
                                :APP_PAGE_ID,
                                SYS_CONTEXT('APEX$SESSION', 'APP_SESSION'),
                                l_loadingTime,
                                sysdate,
                                :app_user); 

    
    
    apex_json.open_object;
    apex_json.close_object;
    
    return l_result;

END ajax_render_loading;