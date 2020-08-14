(function() {
	var now, pageLoadTime, ajaxIdentifier$, th$;
	let div;
	var requestData = {};
	
	var apexloadPage = {
		getTime: function(pItem, pAjaxId) {
			
			th$ = this;
			
			//https://blog.danielhochleitner.de/2018/02/11/oracle-apex-plugin-performance/
			now = new Date().getTime();
			pageLoadTime = (now - performance.timing.navigationStart) / 1000;
			//----------------------------------------------------------------------------
					
			if (pItem)
				apex.item( pItem ).setValue( pageLoadTime  );
					
			//
			requestData.x01 = pageLoadTime;
			
			//Call apex.server.plugin
			th$.ajaxCall(pAjaxId);
		
		},
		
		ajaxCall : function(pAjaxId) {
					apex.server.plugin(pAjaxId, requestData);
					apex.debug.info('APEX Page Loading Time[DEBUG.INFO]: ' , requestData.x01);
		 }
	}	 
	window.apexloadPage = apexloadPage;
})(apex.jQuery);