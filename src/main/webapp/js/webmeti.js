/**
 * 
 */

function storestockdate_list_loadtable(bdate,edate){
	/*alert("storestockdate_list_loadtable "+bdate+" "+edate);*/
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	var t = document.getElementById('storestockdate-list-table');
	    	t.innerHTML = this.responseText;	
	    	$('.container').addClass('container-fluid').removeClass('container');
	    	$('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:8});
	    }	    
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid=menu_storestockdate_list"+"&lang="+sessionStorage.lang+"&bdate="+bdate+"&edate="+edate+"&flag=1", true);
	  xhttp.send();
	}

function orderinfo_supplier_loadtable(bdate,edate,dtype_id,chk0,chk1,chk2,chk3,chk4,chk5,chk6,chk7){
	/*alert("orderinfo_supplier_loadtable "+bdate+" "+edate);*/
	var statuslista = "";
	if (chk0) statuslista += "'0',";
	if (chk1) statuslista += "'1',";
	if (chk2) statuslista += "'2',";
	if (chk3) statuslista += "'3',";
	if (chk4) statuslista += "'4',";
	if (chk5) statuslista += "'5',";
	if (chk6) statuslista += "'6',";
	if (chk7) statuslista += "'7',";
	if (statuslista.length > 0) statuslista = statuslista.substr(0,statuslista.length-1);
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	var t = document.getElementById('tree-list-table');
	    	/*t.innerHTML = this.responseText;*/		    	
	    	var start = this.responseText.indexOf("<script>");
	    	if(start!=-1) {
	    		start=start+8;
	    		var end = this.responseText.indexOf("</script>");
		    	var script = this.responseText.slice(start,end);
		    	eval(script);
	    	}
	    }	    
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid=menu_orderinfo_supplier"+"&lang="+sessionStorage.lang+"&bd="+bdate+"&ed="+edate+"&flag=1"+"&dtype_id="+dtype_id+"&direction=1&statuslista="+statuslista, true);
	  xhttp.send();
	}